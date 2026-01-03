<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeFile="teacher-login.aspx.cs" Inherits="teacher_login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <title>Teacher Portal | ERP-SCHOOL</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Teacher login page for ERP-SCHOOL. Sign in to access your dashboard." />
    <link rel="icon" type="image/png" href="/favicon.ico" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
            overflow-y: auto;
            min-height: 100vh;
        }
        
        .main-container {
            position: relative;
            width: 100%;
            min-height: 100vh;
            padding: 20px 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        /* Animated gradient orbs */
        .orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.6;
            animation: float-orb 20s infinite ease-in-out;
        }
        
        .orb-1 {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.8) 0%, transparent 70%);
            top: -200px;
            left: -200px;
            animation-delay: 0s;
        }
        
        .orb-2 {
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(240, 147, 251, 0.8) 0%, transparent 70%);
            bottom: -150px;
            right: -150px;
            animation-delay: 7s;
        }
        
        .orb-3 {
            width: 350px;
            height: 350px;
            background: radial-gradient(circle, rgba(118, 75, 162, 0.8) 0%, transparent 70%);
            top: 50%;
            left: 50%;
            animation-delay: 14s;
        }
        
        @keyframes float-orb {
            0%, 100% { transform: translate(0, 0) scale(1); }
            25% { transform: translate(100px, -100px) scale(1.1); }
            50% { transform: translate(-100px, 100px) scale(0.9); }
            75% { transform: translate(150px, 50px) scale(1.05); }
        }
        
        /* Particle system */
        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: white;
            border-radius: 50%;
            opacity: 0;
            animation: particle-rise 15s linear infinite;
        }
        
        @keyframes particle-rise {
            0% {
                opacity: 0;
                transform: translateY(100vh) translateX(0) scale(0);
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                transform: translateY(-100vh) translateX(100px) scale(1);
            }
        }
        
        /* Glass card */
        .glass-card {
            position: relative;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            padding: 35px 40px;
            width: 420px;
            max-width: 90vw;
            animation: slide-up 0.8s ease-out;
            z-index: 10;
        }
        
        @keyframes slide-up {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .logo-container {
            text-align: center;
            margin-bottom: 25px;
            animation: fade-in 1s ease-out 0.3s both;
        }
        
        .logo-wrapper {
            position: relative;
            display: inline-block;
            margin-bottom: 12px;
        }
        
        .logo-glow {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 90px;
            height: 90px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.3) 0%, transparent 70%);
            border-radius: 50%;
            animation: pulse-glow 3s ease-in-out infinite;
        }
        
        @keyframes pulse-glow {
            0%, 100% { transform: translate(-50%, -50%) scale(1); opacity: 0.5; }
            50% { transform: translate(-50%, -50%) scale(1.2); opacity: 0.8; }
        }
        
        .logo-img {
            position: relative;
            width: 70px;
            height: 70px;
            border-radius: 50%;
            padding: 12px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }
        
        .title {
            color: white;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 4px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            font-weight: 400;
        }
        
        .input-group {
            position: relative;
            margin-bottom: 18px;
            animation: fade-in 1s ease-out 0.5s both;
        }

        .input-group label {
            display: block;
            color: rgba(255, 255, 255, 0.9);
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 6px;
        }
        
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .input-icon {
            position: absolute;
            left: 14px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 18px;
            transition: color 0.3s ease;
            pointer-events: none;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 44px 12px 44px;
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            color: white;
            font-size: 14px;
            font-weight: 400;
            outline: none;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        
        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        .form-input:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.4);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
        }

        .form-input:focus ~ .input-icon {
            color: white;
        }

        /* Password toggle */
        .toggle-password {
            position: absolute;
            right: 12px;
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.6);
            font-size: 16px;
            cursor: pointer;
            padding: 4px;
            transition: color 0.3s ease;
        }

        .toggle-password:hover,
        .toggle-password:focus {
            color: white;
            outline: none;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            animation: fade-in 1s ease-out 0.6s both;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.9);
            font-size: 13px;
            cursor: pointer;
            gap: 8px;
        }

        /* Custom checkbox */
        .remember-me input[type="checkbox"] {
            appearance: none;
            -webkit-appearance: none;
            width: 18px;
            height: 18px;
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 4px;
            cursor: pointer;
            position: relative;
            transition: all 0.2s ease;
        }

        .remember-me input[type="checkbox"]:checked {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .remember-me input[type="checkbox"]:checked::after {
            content: '\2713';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 14px;
            font-weight: 700;
        }

        .remember-me input[type="checkbox"]:focus {
            outline: 2px solid rgba(255, 255, 255, 0.4);
            outline-offset: 2px;
        }
        
        .forgot-link {
            color: rgba(255, 255, 255, 0.9);
            font-size: 13px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .forgot-link:hover {
            color: white;
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
        }

        .forgot-link:focus {
            outline: 2px solid rgba(255, 255, 255, 0.4);
            outline-offset: 2px;
            border-radius: 4px;
        }
        
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(255, 255, 255, 0.7) 100%);
            color: #667eea;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
            animation: fade-in 1s ease-out 0.7s both;
        }
        
        .btn-login::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.4);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .btn-login:hover::before {
            width: 400px;
            height: 400px;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.3);
        }
        
        .btn-login:active {
            transform: translateY(0);
        }

        .btn-login:focus {
            outline: 2px solid rgba(255, 255, 255, 0.6);
            outline-offset: 2px;
        }
        
        .btn-text {
            position: relative;
            z-index: 1;
        }
        
        .footer-text {
            text-align: center;
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            color: rgba(255, 255, 255, 0.7);
            font-size: 12px;
            animation: fade-in 1s ease-out 0.8s both;
        }
        
        @keyframes fade-in {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-container {
                padding: 20px 10px;
            }

            .glass-card {
                padding: 30px 25px;
            }
            
            .title {
                font-size: 22px;
            }
            
            .logo-img {
                width: 60px;
                height: 60px;
            }

            .logo-glow {
                width: 80px;
                height: 80px;
            }

            .remember-forgot {
                flex-direction: column;
                gap: 12px;
                align-items: flex-start;
            }
        }
        
        /* Loading animation */
        .btn-login.loading {
            pointer-events: none;
        }
        
        .btn-login.loading .btn-text {
            opacity: 0;
        }
        
        .btn-login.loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 3px solid transparent;
            border-top-color: #667eea;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="main-container" id="mainContainer">
        <!-- Animated orbs -->
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
        
        <form id="form1" runat="server" class="glass-card">
            <div class="logo-container">
                <div class="logo-wrapper">
                    <div class="logo-glow"></div>
                    <img src="assets/images/education.gif" alt="ERP-SCHOOL Logo" class="logo-img" />
                </div>
                <h1 class="title">Welcome Back</h1>
                <p class="subtitle">Sign in to your teacher portal</p>
            </div>
            
            <div class="input-group">
                <label for="<%= txtUsername.ClientID %>">Email or Mobile Number</label>
                <div class="input-wrapper">
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your email or mobile" CssClass="form-input" autocomplete="username" required="required" />
                    <i class="bi bi-person-circle input-icon" aria-hidden="true"></i>
                </div>
            </div>
            
            <div class="input-group">
                <label for="<%= txtPassword.ClientID %>">Password</label>
                <div class="input-wrapper">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" CssClass="form-input" autocomplete="current-password" required="required" />
                    <i class="bi bi-lock-fill input-icon" aria-hidden="true"></i>
                    <button type="button" class="toggle-password" aria-label="Show password" onclick="togglePassword()">
                        <i class="bi bi-eye" id="toggleIcon"></i>
                    </button>
                </div>
            </div>
            
            <div class="remember-forgot">
                <label class="remember-me">
                    <asp:CheckBox ID="chkRemember" runat="server" />
                    <span>Remember me</span>
                </label>
                <a href="forgotpassword.aspx" class="forgot-link">Forgot Password?</a>
            </div>
            
            <asp:Button ID="btnLogin" runat="server" CssClass="btn-login" OnClick="btnLogin_Click" OnClientClick="setLoading(); return true;" Text="Sign In" />
            
            <div class="footer-text">
                &copy; <%= DateTime.Now.Year %> LOGICAL WAVE. All rights reserved.
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Create particles after container exists
            var container = document.getElementById('mainContainer');
            for (var i = 0; i < 30; i++) {
                var particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + 'vw';
                particle.style.animationDelay = Math.random() * 15 + 's';
                particle.style.animationDuration = (15 + Math.random() * 10) + 's';
                container.appendChild(particle);
            }
        });

        // Password toggle
        function togglePassword() {
            var pwdField = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById('toggleIcon');
            var btn = icon.parentElement;
            if (pwdField.type === 'password') {
                pwdField.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
                btn.setAttribute('aria-label', 'Hide password');
            } else {
                pwdField.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
                btn.setAttribute('aria-label', 'Show password');
            }
        }

        // Loading state management
        function setLoading() {
            var btn = document.getElementById('<%= btnLogin.ClientID %>');
            btn.classList.add('loading');
        }

        // Reset loading state on page load (e.g., validation failed postback)
        window.addEventListener('load', function () {
            var btn = document.getElementById('<%= btnLogin.ClientID %>');
            btn.classList.remove('loading');
        });
    </script>
</body>
</html>