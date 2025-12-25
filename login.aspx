<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <title>Login | ERP-SCHOOL</title>

    <!-- SEO Meta -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Secure login page for ERP-SCHOOL. Sign in to access your dashboard." />
    <meta name="keywords" content="ERP-SCHOOL, School ERP Login, Education Management, Secure Access" />
    <meta name="author" content="ERP-SCHOOL Team" />


    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/favicon.ico" />

    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"/>

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-out'
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0', transform: 'translateY(10px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        }
                    }
                }
            }
        }
    </script>

    <style type="text/css">
        .bg-auth {
            background: linear-gradient(120deg, #4f46e5 0%, #7e22ce 100%);
            position: relative;
            overflow: hidden;
        }

            .bg-auth::before {
                content: "";
                position: absolute;
                width: 500px;
                height: 500px;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.1);
                top: -250px;
                right: -250px;
            }

            .bg-auth::after {
                content: "";
                position: absolute;
                width: 500px;
                height: 500px;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.07);
                bottom: -300px;
                left: -250px;
            }

        .form-container {
            position: relative;
            z-index: 10;
            background: #fff;
        }

        .bg-auth::before, .bg-auth::after {
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% {
                transform: translateY(0) translateX(0) rotate(0deg);
            }

            50% {
                transform: translateY(-50px) translateX(50px) rotate(180deg);
            }

            100% {
                transform: translateY(0) translateX(0) rotate(360deg);
            }
        }

        .bubble {
            position: absolute;
            bottom: -100px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            animation: rise 15s linear infinite;
        }

            /* Randomize size, position, duration, and delay for natural effect */
            .bubble:nth-child(1) {
                width: 40px;
                height: 40px;
                left: 5%;
                animation-duration: 12s;
                animation-delay: 0s;
            }

            .bubble:nth-child(2) {
                width: 60px;
                height: 60px;
                left: 15%;
                animation-duration: 18s;
                animation-delay: 2s;
            }

            .bubble:nth-child(3) {
                width: 30px;
                height: 30px;
                left: 30%;
                animation-duration: 14s;
                animation-delay: 4s;
            }

            .bubble:nth-child(4) {
                width: 50px;
                height: 50px;
                left: 45%;
                animation-duration: 16s;
                animation-delay: 1s;
            }

            .bubble:nth-child(5) {
                width: 25px;
                height: 25px;
                left: 60%;
                animation-duration: 20s;
                animation-delay: 3s;
            }

            .bubble:nth-child(6) {
                width: 45px;
                height: 45px;
                left: 70%;
                animation-duration: 17s;
                animation-delay: 5s;
            }

            .bubble:nth-child(7) {
                width: 35px;
                height: 35px;
                left: 80%;
                animation-duration: 13s;
                animation-delay: 2s;
            }

            .bubble:nth-child(8) {
                width: 55px;
                height: 55px;
                left: 90%;
                animation-duration: 19s;
                animation-delay: 0s;
            }

        @keyframes rise {
            0% {
                transform: translateY(0) translateX(0) scale(1);
                opacity: 0.3;
            }

            50% {
                opacity: 0.6;
            }

            100% {
                transform: translateY(-700px) translateX(50px) scale(1.2);
                opacity: 0;
            }
        }
    </style>
</head>
<body class="bg-auth min-h-screen flex items-center justify-center p-4">
    <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2MCIgaGVpZ2h0PSI2MCIgdmlld0JveD0iMCAwIDYwIDYwIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PHBhdGggZD0iTTM2IDM0djRoLTR2LTRoNHptLTQtMjB2NGg0di00aC00em0yMCAyMHY0aC00di00aDR6bS00LTh2NGg0di00aC00ek0xMiAxNHY0SDh2LTRoNHptLTggOHY0SDB2LTRoNHptOC04djRIMTB2LTRoNHptMTYgMHY0aC00di00aDR6bS04LTh2NGgtNHY0aC00di00aDR2LTRoNHptMCAxNnY0aC00di00aDR6bS0xNiAwdjRoLTR2LTRoNHoiLz48L2c+PC9nPjwvc3ZnPg==')] opacity-20"></div>
    <div class="absolute inset-0 z-0 overflow-hidden">
        <span class="bubble"></span>
        <span class="bubble"></span>
        <span class="bubble"></span>
        <span class="bubble"></span>
        <span class="bubble"></span>
        <span class="bubble"></span>
        <span class="bubble"></span>
        <span class="bubble"></span>
    </div>

    <form id="form1" runat="server" class="form-container shadow-lg rounded-lg p-8 w-full max-w-sm">
        <div class="text-center mb-6">
            <%--<i class="bi bi-mortarboard-fill text-3xl text-indigo-600"></i>--%>
            <img src="assets/images/education.gif" alt="ERP-SCHOOL Logo" class="mx-auto h-20 w-20" />   
            <h3 class="text-xl font-bold mt-2">Admin Login</h3>
        </div>

        <div class="mb-4">
            <label for="txtUsername" class="block text-sm font-medium text-gray-700">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter Your Username" CssClass="mt-1 block w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring focus:ring-indigo-300" />
        </div>

        <div class="mb-4">
            <label for="txtPassword" class="block text-sm font-medium text-gray-700">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter Your Password" CssClass="mt-1 block w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring focus:ring-indigo-300" />
        </div>

        <div class="flex items-start mb-4">
            <div>
                <asp:CheckBox ID="chkRemember" runat="server" CssClass="mr-1" />
                <label for="chkRemember" class="text-sm text-gray-600">Remember me</label>
            </div>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2 rounded-lg transition cursor-pointer" OnClick="btnLogin_Click" />

        <p class="text-center text-sm text-gray-600 mt-4">
            Forgot Your Password? 
            <a href="forgotpassword.aspx" class="text-indigo-600 hover:underline">Contact Admin</a>
        </p>
        <div class="mt-8 pt-5 border-t border-gray-200">
            <p class="text-xs text-center text-gray-500">
                &copy; <%= DateTime.Now.Year %> LOGICAL WAVE. All rights reserved.
            </p>
        </div>
    </form>
</body>
</html>
