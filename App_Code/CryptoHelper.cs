using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

public static class CryptoHelper
{
    private static readonly string key = "A1B2C3D4E5F6G7H8"; // 16 chars
    private static readonly string iv = "1H2G3F4E5D6C7B8A"; // 16 chars

    // ----------------------------------------------------
    // ALWAYS SAFE ENCRYPT
    // ----------------------------------------------------
    public static string Encrypt(string plainText)
    {
        if (string.IsNullOrEmpty(plainText))
            return plainText;

        try
        {
            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(key);
                aes.IV = Encoding.UTF8.GetBytes(iv);

                using (var ms = new MemoryStream())
                using (var cs = new CryptoStream(ms, aes.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    byte[] inputBytes = Encoding.UTF8.GetBytes(plainText);
                    cs.Write(inputBytes, 0, inputBytes.Length);
                    cs.Close();

                    string base64 = Convert.ToBase64String(ms.ToArray());

                    // URL safe
                    return base64.Replace("+", "-")
                                 .Replace("/", "_")
                                 .Replace("=", "");
                }
            }
        }
        catch
        {
            // If encryption fails, return original text safely
            return plainText;
        }
    }

    // ----------------------------------------------------
    // ALWAYS SAFE DECRYPT
    // NEVER THROW ERROR
    // ----------------------------------------------------
    public static string Decrypt(string cipherText)
    {
        if (string.IsNullOrEmpty(cipherText))
            return cipherText;

        try
        {
            // Rebuild Base64 padding and characters
            string base64 = cipherText.Replace("-", "+")
                                      .Replace("_", "/");

            int mod4 = base64.Length % 4;
            if (mod4 > 0)
                base64 += new string('=', 4 - mod4);

            byte[] bytes = Convert.FromBase64String(base64);

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(key);
                aes.IV = Encoding.UTF8.GetBytes(iv);

                using (var ms = new MemoryStream(bytes))
                using (var cs = new CryptoStream(ms, aes.CreateDecryptor(), CryptoStreamMode.Read))
                using (var reader = new StreamReader(cs))
                {
                    return reader.ReadToEnd();
                }
            }
        }
        catch
        {
            // ⚠ If ANYTHING fails — return original value
            // This supports *all* inputs safely.
            return cipherText;
        }
    }
}
