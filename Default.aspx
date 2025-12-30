<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Westbrook Academy - Excellence in Education</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
        }
        
        .font-playfair {
            font-family: 'Playfair Display', serif;
        }
        
        .gradient-primary {
            background: linear-gradient(135deg, #1e3a5f 0%, #2d5a87 100%);
        }
        
        .gradient-accent {
            background: linear-gradient(135deg, #c9a227 0%, #e8c547 100%);
        }
        
        .hero-section {
            background: linear-gradient(135deg, rgba(30, 58, 95, 0.9) 0%, rgba(45, 90, 135, 0.85) 100%),
                        url('https://images.unsplash.com/photo-1562774053-701939374585?w=1920') center/cover;
            min-height: 100vh;
        }
        
        .nav-link {
            position: relative;
            transition: color 0.3s ease;
        }
        
        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            width: 0;
            height: 2px;
            background: #c9a227;
            transition: width 0.3s ease;
        }
        
        .nav-link:hover::after {
            width: 100%;
        }
        
        .card-hover {
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        .card-hover:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }
        
        .stat-card {
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
            border: 1px solid rgba(201, 162, 39, 0.2);
        }
        
        .animate-float {
            animation: float 6s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        
        .scroll-indicator {
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }
        
        .feature-icon {
            background: linear-gradient(135deg, #1e3a5f 0%, #2d5a87 100%);
            transition: all 0.3s ease;
        }
        
        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
            background: linear-gradient(135deg, #c9a227 0%, #e8c547 100%);
        }
        
        .testimonial-card {
            background: linear-gradient(145deg, #ffffff 0%, #f1f5f9 100%);
        }
        
        .news-image {
            transition: transform 0.5s ease;
        }
        
        .news-card:hover .news-image {
            transform: scale(1.1);
        }
        
        .mobile-menu {
            transform: translateX(100%);
            transition: transform 0.3s ease;
        }
        
        .mobile-menu.active {
            transform: translateX(0);
        }
        
        .counter {
            font-variant-numeric: tabular-nums;
        }
        
        .cta-section {
            background: linear-gradient(135deg, rgba(30, 58, 95, 0.95) 0%, rgba(45, 90, 135, 0.9) 100%),
                        url('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=1920') center/cover fixed;
        }
        
        .footer-gradient {
            background: linear-gradient(180deg, #1e3a5f 0%, #0f1e30 100%);
        }
        
        input:focus, textarea:focus {
            outline: none;
            border-color: #c9a227;
            box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.2);
        }
        
        .gallery-item {
            overflow: hidden;
        }
        
        .gallery-item img {
            transition: transform 0.5s ease;
        }
        
        .gallery-item:hover img {
            transform: scale(1.1);
        }
        
        .gallery-overlay {
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .gallery-item:hover .gallery-overlay {
            opacity: 1;
        }
    </style>
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
        <!-- Navigation -->
        <nav class="fixed w-full z-50 transition-all duration-300" id="navbar">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <!-- Logo -->
                    <div class="flex items-center space-x-3">
                        <div class="w-12 h-12 gradient-accent rounded-lg flex items-center justify-center">
                            <!-- Logo image populated from DB -->
                            <asp:Image ID="imgLogo" runat="server" CssClass="w-8 h-8 object-contain" />
                        </div>
                        <div>
                            <h1 class="font-playfair font-bold text-xl text-white"><asp:Literal ID="litSchoolName" runat="server" /></h1>
                            <p class="text-xs text-gray-300 -mt-1"><asp:Literal ID="litSchoolTag" runat="server" /></p>
                        </div>
                    </div>
                    
                    <!-- Desktop Navigation -->
                    <div class="hidden lg:flex items-center space-x-8" id="desktopNav">
                        <!-- navigation links remain static -->
                        <a href="#home" class="nav-link text-white font-medium">Home</a>
                        <a href="#about" class="nav-link text-white font-medium">About Us</a>
                        <a href="#programs" class="nav-link text-white font-medium">Programs</a>
                        <a href="#admissions" class="nav-link text-white font-medium">Admissions</a>
                        <a href="#news" class="nav-link text-white font-medium">News</a>
                        <a href="#contact" class="nav-link text-white font-medium">Contact</a>
                        <button class="gradient-accent text-white px-6 py-2 rounded-full font-semibold hover:opacity-90 transition-opacity">
                            Apply Now
                        </button>
                    </div>
                    
                    <!-- Mobile Menu Button -->
                    <button class="lg:hidden text-white text-2xl" id="menuBtn" type="button">
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
            </div>
        </nav>

        <!-- Hidden fields for contact details populated from DB -->
        <asp:HiddenField ID="hfPhone" runat="server" />
        <asp:HiddenField ID="hfEmail" runat="server" />

        <!-- Mobile Menu -->
        <div class="mobile-menu fixed top-0 right-0 w-80 h-full bg-slate-900 z-50 p-8" id="mobileMenu">
            <button class="absolute top-6 right-6 text-white text-2xl" id="closeMenu">
                <i class="fas fa-times"></i>
            </button>
            <div class="mt-16 space-y-6">
                <a href="#home" class="block text-white text-lg font-medium hover:text-yellow-400 transition-colors">Home</a>
                <a href="#about" class="block text-white text-lg font-medium hover:text-yellow-400 transition-colors">About Us</a>
                <a href="#programs" class="block text-white text-lg font-medium hover:text-yellow-400 transition-colors">Programs</a>
                <a href="#admissions" class="block text-white text-lg font-medium hover:text-yellow-400 transition-colors">Admissions</a>
                <a href="#news" class="block text-white text-lg font-medium hover:text-yellow-400 transition-colors">News</a>
                <a href="#contact" class="block text-white text-lg font-medium hover:text-yellow-400 transition-colors">Contact</a>
                <button class="gradient-accent text-white px-6 py-3 rounded-full font-semibold w-full mt-8">
                    Apply Now
                </button>
            </div>
        </div>
        
        <!-- Hero Section -->
        <section id="home" class="hero-section flex items-center justify-center relative pt-20">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <div class="animate-float">
                    <span class="inline-block gradient-accent text-white px-4 py-2 rounded-full text-sm font-semibold mb-6">
                        🎓 Admissions Open for 2025-2026
                    </span>
                </div>
                <h1 class="font-playfair text-4xl md:text-6xl lg:text-7xl font-bold text-white leading-tight mb-6">
                    Shaping Tomorrow's<br>
                    <span class="text-yellow-400">Leaders</span> Today
                </h1>
                <p class="text-gray-200 text-lg md:text-xl max-w-2xl mx-auto mb-10">
                    At Westbrook Academy, we nurture young minds with excellence in academics, 
                    character development, and innovative learning experiences.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <button class="gradient-accent text-white px-8 py-4 rounded-full font-semibold text-lg hover:shadow-2xl transition-all transform hover:scale-105">
                        <i class="fas fa-play-circle mr-2"></i> Virtual Tour
                    </button>
                    <button class="bg-white/10 backdrop-blur-sm text-white px-8 py-4 rounded-full font-semibold text-lg border-2 border-white/30 hover:bg-white/20 transition-all">
                        <i class="fas fa-calendar-alt mr-2"></i> Schedule Visit
                    </button>
                </div>
            </div>
            
            <!-- Scroll Indicator -->
            <div class="absolute bottom-10 left-1/2 transform -translate-x-1/2 scroll-indicator">
                <a href="#about" class="text-white/70 hover:text-white transition-colors">
                    <i class="fas fa-chevron-down text-2xl"></i>
                </a>
            </div>
        </section>
        
        <!-- Stats Section -->
        <section class="py-8 bg-white shadow-lg relative -mt-16 mx-4 lg:mx-auto max-w-6xl rounded-2xl z-10">
            <div class="grid grid-cols-2 md:grid-cols-4 gap-8 px-8">
                <div class="text-center">
                    <div class="text-3xl md:text-4xl font-bold text-slate-800 counter" data-target="2500">0</div>
                    <p class="text-gray-500 mt-1">Students</p>
                </div>
                <div class="text-center">
                    <div class="text-3xl md:text-4xl font-bold text-slate-800 counter" data-target="150">0</div>
                    <p class="text-gray-500 mt-1">Faculty Members</p>
                </div>
                <div class="text-center">
                    <div class="text-3xl md:text-4xl font-bold text-slate-800 counter" data-target="98">0</div>
                    <p class="text-gray-500 mt-1">% Graduation Rate</p>
                </div>
                <div class="text-center">
                    <div class="text-3xl md:text-4xl font-bold text-slate-800 counter" data-target="75">0</div>
                    <p class="text-gray-500 mt-1">Years of Excellence</p>
                </div>
            </div>
        </section>
        
        <!-- About Section -->
        <section id="about" class="py-20 lg:py-32">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid lg:grid-cols-2 gap-16 items-center">
                    <div class="relative">
                        <div class="relative z-10">
                            <img src="https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=600" 
                                 alt="Students learning" 
                                 class="rounded-2xl shadow-2xl w-full">
                        </div>
                        <div class="absolute -bottom-8 -right-8 w-64 h-64 gradient-primary rounded-2xl -z-10"></div>
                        <div class="absolute -top-4 -left-4 w-32 h-32 gradient-accent rounded-xl -z-10 opacity-80"></div>
                        
                        <!-- Floating Card -->
                        <div class="absolute -bottom-6 -left-6 bg-white p-6 rounded-xl shadow-xl z-20 hidden md:block">
                            <div class="flex items-center space-x-4">
                                <div class="w-14 h-14 gradient-accent rounded-full flex items-center justify-center">
                                    <i class="fas fa-award text-white text-xl"></i>
                                </div>
                                <div>
                                    <p class="font-bold text-slate-800 text-lg">#1 Ranked</p>
                                    <p class="text-gray-500 text-sm">Private School in State</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <span class="text-yellow-600 font-semibold tracking-wider uppercase text-sm">About Our School</span>
                        <h2 class="font-playfair text-4xl lg:text-5xl font-bold text-slate-800 mt-3 mb-6">
                            A Legacy of Academic Excellence Since 1949
                        </h2>
                        <p class="text-gray-600 text-lg leading-relaxed mb-6">
                            Westbrook Academy has been at the forefront of education for over seven decades, 
                            consistently producing graduates who excel in higher education and professional careers.
                        </p>
                        <p class="text-gray-600 leading-relaxed mb-8">
                            Our commitment to holistic development ensures that every student not only achieves 
                            academic excellence but also develops strong character, leadership skills, and a 
                            sense of social responsibility.
                        </p>
                        
                        <div class="grid sm:grid-cols-2 gap-4 mb-8">
                            <div class="flex items-center space-x-3">
                                <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center">
                                    <i class="fas fa-check text-green-600"></i>
                                </div>
                                <span class="text-gray-700 font-medium">Accredited Curriculum</span>
                            </div>
                            <div class="flex items-center space-x-3">
                                <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center">
                                    <i class="fas fa-check text-green-600"></i>
                                </div>
                                <span class="text-gray-700 font-medium">Expert Faculty</span>
                            </div>
                            <div class="flex items-center space-x-3">
                                <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center">
                                    <i class="fas fa-check text-green-600"></i>
                                </div>
                                <span class="text-gray-700 font-medium">Modern Facilities</span>
                            </div>
                            <div class="flex items-center space-x-3">
                                <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center">
                                    <i class="fas fa-check text-green-600"></i>
                                </div>
                                <span class="text-gray-700 font-medium">Safe Environment</span>
                            </div>
                        </div>
                        
                        <button class="gradient-primary text-white px-8 py-4 rounded-full font-semibold inline-flex items-center hover:shadow-lg transition-all">
                            Learn More About Us <i class="fas fa-arrow-right ml-3"></i>
                        </button>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Programs Section -->
        <section id="programs" class="py-20 lg:py-32 bg-gradient-to-b from-slate-50 to-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <span class="text-yellow-600 font-semibold tracking-wider uppercase text-sm">Our Programs</span>
                    <h2 class="font-playfair text-4xl lg:text-5xl font-bold text-slate-800 mt-3 mb-6">
                        Academic Programs
                    </h2>
                    <p class="text-gray-600 text-lg max-w-2xl mx-auto">
                        Comprehensive educational programs designed to nurture every student's potential 
                        from early childhood through high school graduation.
                    </p>
                </div>
                
                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- Elementary -->
                    <div class="feature-card bg-white rounded-2xl p-8 card-hover shadow-lg">
                        <div class="feature-icon w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                            <i class="fas fa-child text-white text-2xl"></i>
                        </div>
                        <h3 class="font-playfair text-2xl font-bold text-slate-800 mb-4">Elementary School</h3>
                        <p class="text-gray-600 mb-6">
                            Building strong foundations through play-based learning, phonics, 
                            mathematics, and social development for grades K-5.
                        </p>
                        <ul class="space-y-2 mb-6">
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                Small class sizes (15:1 ratio)
                            </li>
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                Integrated STEAM curriculum
                            </li>
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                Character education program
                            </li>
                        </ul>
                        <a href="#" class="text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                            Learn More <i class="fas fa-arrow-right ml-1"></i>
                        </a>
                    </div>
                    
                    <!-- Middle School -->
                    <div class="feature-card bg-white rounded-2xl p-8 card-hover shadow-lg">
                        <div class="feature-icon w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                            <i class="fas fa-book-reader text-white text-2xl"></i>
                        </div>
                        <h3 class="font-playfair text-2xl font-bold text-slate-800 mb-4">Middle School</h3>
                        <p class="text-gray-600 mb-6">
                            Challenging academics combined with exploration opportunities 
                            to help students discover their passions in grades 6-8.
                        </p>
                        <ul class="space-y-2 mb-6">
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                Advanced placement tracks
                            </li>
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                Leadership development
                            </li>
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                Extracurricular activities
                            </li>
                        </ul>
                        <a href="#" class="text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                            Learn More <i class="fas fa-arrow-right ml-1"></i>
                        </a>
                    </div>
                    
                    <!-- High School -->
                    <div class="feature-card bg-white rounded-2xl p-8 card-hover shadow-lg">
                        <div class="feature-icon w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                            <i class="fas fa-university text-white text-2xl"></i>
                        </div>
                        <h3 class="font-playfair text-2xl font-bold text-slate-800 mb-4">High School</h3>
                        <p class="text-gray-600 mb-6">
                            College preparatory curriculum with AP courses, dual enrollment, 
                            and comprehensive college counseling for grades 9-12.
                        </p>
                        <ul class="space-y-2 mb-6">
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                20+ AP courses offered
                            </li>
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                College counseling support
                            </li>
                            <li class="flex items-center text-gray-600">
                                <i class="fas fa-star text-yellow-500 mr-2 text-sm"></i>
                                Internship opportunities
                            </li>
                        </ul>
                        <a href="#" class="text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                            Learn More <i class="fas fa-arrow-right ml-1"></i>
                        </a>
                    </div>
                </div>
                
                <!-- Special Programs -->
                <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6 mt-12">
                    <div class="bg-gradient-to-br from-blue-900 to-blue-700 rounded-xl p-6 text-white card-hover">
                        <i class="fas fa-flask text-3xl mb-4 text-yellow-400"></i>
                        <h4 class="font-bold text-lg mb-2">STEM Excellence</h4>
                        <p class="text-blue-100 text-sm">Robotics, coding, and scientific research programs</p>
                    </div>
                    <div class="bg-gradient-to-br from-purple-900 to-purple-700 rounded-xl p-6 text-white card-hover">
                        <i class="fas fa-palette text-3xl mb-4 text-yellow-400"></i>
                        <h4 class="font-bold text-lg mb-2">Arts Academy</h4>
                        <p class="text-purple-100 text-sm">Visual arts, music, theater, and dance programs</p>
                    </div>
                    <div class="bg-gradient-to-br from-green-900 to-green-700 rounded-xl p-6 text-white card-hover">
                        <i class="fas fa-futbol text-3xl mb-4 text-yellow-400"></i>
                        <h4 class="font-bold text-lg mb-2">Athletics</h4>
                        <p class="text-green-100 text-sm">15+ varsity sports with championship tradition</p>
                    </div>
                    <div class="bg-gradient-to-br from-orange-800 to-orange-600 rounded-xl p-6 text-white card-hover">
                        <i class="fas fa-globe text-3xl mb-4 text-yellow-400"></i>
                        <h4 class="font-bold text-lg mb-2">Global Studies</h4>
                        <p class="text-orange-100 text-sm">Exchange programs and international partnerships</p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Admissions Section -->
        <section id="admissions" class="py-20 lg:py-32">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid lg:grid-cols-2 gap-16 items-center">
                    <div>
                        <span class="text-yellow-600 font-semibold tracking-wider uppercase text-sm">Admissions</span>
                        <h2 class="font-playfair text-4xl lg:text-5xl font-bold text-slate-800 mt-3 mb-6">
                            Begin Your Journey With Us
                        </h2>
                        <p class="text-gray-600 text-lg leading-relaxed mb-8">
                            We welcome students who are eager to learn, grow, and contribute to our 
                            vibrant school community. Our admissions process is designed to help us 
                            understand each applicant's unique strengths and potential.
                        </p>
                        
                        <!-- Timeline -->
                        <div class="space-y-6">
                            <div class="flex items-start space-x-4">
                                <div class="w-12 h-12 gradient-accent rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-white font-bold">1</span>
                                </div>
                                <div>
                                    <h4 class="font-bold text-slate-800 text-lg">Submit Application</h4>
                                    <p class="text-gray-600">Complete online application with required documents</p>
                                </div>
                            </div>
                            <div class="flex items-start space-x-4">
                                <div class="w-12 h-12 gradient-accent rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-white font-bold">2</span>
                                </div>
                                <div>
                                    <h4 class="font-bold text-slate-800 text-lg">Campus Visit & Assessment</h4>
                                    <p class="text-gray-600">Tour our facilities and complete age-appropriate assessment</p>
                                </div>
                            </div>
                            <div class="flex items-start space-x-4">
                                <div class="w-12 h-12 gradient-accent rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-white font-bold">3</span>
                                </div>
                                <div>
                                    <h4 class="font-bold text-slate-800 text-lg">Family Interview</h4>
                                    <p class="text-gray-600">Meet with admissions team to discuss goals and expectations</p>
                                </div>
                            </div>
                            <div class="flex items-start space-x-4">
                                <div class="w-12 h-12 gradient-accent rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-white font-bold">4</span>
                                </div>
                                <div>
                                    <h4 class="font-bold text-slate-800 text-lg">Admission Decision</h4>
                                    <p class="text-gray-600">Receive decision and enrollment package within 2 weeks</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-10 flex flex-wrap gap-4">
                            <button class="gradient-primary text-white px-8 py-4 rounded-full font-semibold hover:shadow-lg transition-all">
                                Apply Online
                            </button>
                            <button class="border-2 border-slate-800 text-slate-800 px-8 py-4 rounded-full font-semibold hover:bg-slate-800 hover:text-white transition-all">
                                Download Brochure
                            </button>
                        </div>
                    </div>
                    
                    <!-- Inquiry Form -->
                    <div class="bg-white rounded-2xl shadow-2xl p-8 lg:p-10">
                        <h3 class="font-playfair text-2xl font-bold text-slate-800 mb-2">Request Information</h3>
                        <p class="text-gray-600 mb-8">Fill out the form below and our admissions team will contact you.</p>
                        
                        <form class="space-y-6" id="inquiryForm">
                            <div class="grid sm:grid-cols-2 gap-6">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Parent/Guardian Name *</label>
                                    <input type="text" required 
                                           class="w-full px-4 py-3 rounded-lg border border-gray-300 transition-all"
                                           placeholder="Full name">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Email Address *</label>
                                    <input type="email" required 
                                           class="w-full px-4 py-3 rounded-lg border border-gray-300 transition-all"
                                           placeholder="email@example.com">
                                </div>
                            </div>
                            <div class="grid sm:grid-cols-2 gap-6">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Phone Number *</label>
                                    <input type="tel" required 
                                           class="w-full px-4 py-3 rounded-lg border border-gray-300 transition-all"
                                           placeholder="(555) 123-4567">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Student's Grade Level *</label>
                                    <select required class="w-full px-4 py-3 rounded-lg border border-gray-300 transition-all bg-white">
                                        <option value="">Select grade</option>
                                        <option value="k">Kindergarten</option>
                                        <option value="1-5">Elementary (1-5)</option>
                                        <option value="6-8">Middle School (6-8)</option>
                                        <option value="9-12">High School (9-12)</option>
                                    </select>
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Student's Name</label>
                                <input type="text" 
                                       class="w-full px-4 py-3 rounded-lg border border-gray-300 transition-all"
                                       placeholder="Student's full name">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Message</label>
                                <textarea rows="4" 
                                          class="w-full px-4 py-3 rounded-lg border border-gray-300 transition-all resize-none"
                                          placeholder="Tell us about your child and any questions you have..."></textarea>
                            </div>
                            <button type="submit" 
                                    class="w-full gradient-accent text-white py-4 rounded-lg font-semibold text-lg hover:opacity-90 transition-opacity">
                                Submit Inquiry
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Testimonials -->
        <section class="py-20 lg:py-32 bg-slate-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <span class="text-yellow-600 font-semibold tracking-wider uppercase text-sm">Testimonials</span>
                    <h2 class="font-playfair text-4xl lg:text-5xl font-bold text-slate-800 mt-3 mb-6">
                        What Our Community Says
                    </h2>
                </div>
                
                <div class="grid md:grid-cols-3 gap-8">
                    <div class="testimonial-card rounded-2xl p-8 card-hover shadow-lg">
                        <div class="flex items-center mb-4">
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                        </div>
                        <p class="text-gray-600 italic mb-6">
                            "Westbrook Academy has been the perfect fit for our family. The teachers genuinely 
                            care about each student's success, and the community feels like an extended family."
                        </p>
                        <div class="flex items-center">
                            <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100" 
                                 alt="Parent" class="w-12 h-12 rounded-full object-cover">
                            <div class="ml-4">
                                <h4 class="font-bold text-slate-800">Sarah Mitchell</h4>
                                <p class="text-gray-500 text-sm">Parent of 2nd Grader</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="testimonial-card rounded-2xl p-8 card-hover shadow-lg">
                        <div class="flex items-center mb-4">
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                        </div>
                        <p class="text-gray-600 italic mb-6">
                            "The college counseling program was exceptional. Thanks to Westbrook, I was 
                            accepted to my dream university with a full scholarship. Forever grateful!"
                        </p>
                        <div class="flex items-center">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100" 
                                 alt="Alumni" class="w-12 h-12 rounded-full object-cover">
                            <div class="ml-4">
                                <h4 class="font-bold text-slate-800">Michael Chen</h4>
                                <p class="text-gray-500 text-sm">Class of 2023 Alumnus</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="testimonial-card rounded-2xl p-8 card-hover shadow-lg">
                        <div class="flex items-center mb-4">
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                            <i class="fas fa-star text-yellow-500"></i>
                        </div>
                        <p class="text-gray-600 italic mb-6">
                            "As a teacher here for 15 years, I can say the administration truly supports 
                            innovation in education. It's a place where both students and teachers thrive."
                        </p>
                        <div class="flex items-center">
                            <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100" 
                                 alt="Teacher" class="w-12 h-12 rounded-full object-cover">
                            <div class="ml-4">
                                <h4 class="font-bold text-slate-800">Dr. Emily Roberts</h4>
                                <p class="text-gray-500 text-sm">Science Department Head</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- News Section -->
        <section id="news" class="py-20 lg:py-32">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col md:flex-row md:items-end md:justify-between mb-16">
                    <div>
                        <span class="text-yellow-600 font-semibold tracking-wider uppercase text-sm">Latest Updates</span>
                        <h2 class="font-playfair text-4xl lg:text-5xl font-bold text-slate-800 mt-3">
                            News & Events
                        </h2>
                    </div>
                    <a href="#" class="text-blue-800 font-semibold hover:text-yellow-600 transition-colors mt-4 md:mt-0">
                        View All News <i class="fas fa-arrow-right ml-1"></i>
                    </a>
                </div>
                
                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- News Card 1 -->
                    <article class="news-card bg-white rounded-2xl overflow-hidden shadow-lg card-hover">
                        <div class="overflow-hidden h-48">
                            <img src="https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?w=600" 
                                 alt="Science Fair" 
                                 class="news-image w-full h-full object-cover">
                        </div>
                        <div class="p-6">
                            <div class="flex items-center space-x-4 mb-4">
                                <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm font-medium">Event</span>
                                <span class="text-gray-500 text-sm">Dec 15, 2024</span>
                            </div>
                            <h3 class="font-playfair text-xl font-bold text-slate-800 mb-3">
                                Annual Science Fair Winners Announced
                            </h3>
                            <p class="text-gray-600 mb-4">
                                Congratulations to all participants in this year's science fair. Our students 
                                showcased incredible innovation and scientific thinking...
                            </p>
                            <a href="#" class="text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                                Read More <i class="fas fa-arrow-right ml-1"></i>
                            </a>
                        </div>
                    </article>
                    
                    <!-- News Card 2 -->
                    <article class="news-card bg-white rounded-2xl overflow-hidden shadow-lg card-hover">
                        <div class="overflow-hidden h-48">
                            <img src="https://images.unsplash.com/photo-1571260899304-425eee4c7efc?w=600" 
                                 alt="College Acceptances" 
                                 class="news-image w-full h-full object-cover">
                        </div>
                        <div class="p-6">
                            <div class="flex items-center space-x-4 mb-4">
                                <span class="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm font-medium">Achievement</span>
                                <span class="text-gray-500 text-sm">Dec 10, 2024</span>
                            </div>
                            <h3 class="font-playfair text-xl font-bold text-slate-800 mb-3">
                                Record Ivy League Acceptances for Class of 2025
                            </h3>
                            <p class="text-gray-600 mb-4">
                                We're proud to announce that 45 seniors have received early admission offers 
                                from Ivy League universities this year...
                            </p>
                            <a href="#" class="text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                                Read More <i class="fas fa-arrow-right ml-1"></i>
                            </a>
                        </div>
                    </article>
                    
                    <!-- News Card 3 -->
                    <article class="news-card bg-white rounded-2xl overflow-hidden shadow-lg card-hover">
                        <div class="overflow-hidden h-48">
                            <img src="https://images.unsplash.com/photo-1509062522246-3755977927d7?w=600" 
                                 alt="New Library" 
                                 class="news-image w-full h-full object-cover">
                        </div>
                        <div class="p-6">
                            <div class="flex items-center space-x-4 mb-4">
                                <span class="bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-sm font-medium">Campus</span>
                                <span class="text-gray-500 text-sm">Dec 5, 2024</span>
                            </div>
                            <h3 class="font-playfair text-xl font-bold text-slate-800 mb-3">
                                New STEM Building Opens Spring 2025
                            </h3>
                            <p class="text-gray-600 mb-4">
                                Construction is complete on our state-of-the-art STEM building featuring 
                                robotics labs, maker spaces, and innovation centers...
                            </p>
                            <a href="#" class="text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                                Read More <i class="fas fa-arrow-right ml-1"></i>
                            </a>
                        </div>
                    </article>
                </div>
                
                <!-- Upcoming Events -->
                <div class="mt-16 bg-gradient-to-r from-slate-800 to-slate-900 rounded-2xl p-8 lg:p-12">
                    <h3 class="font-playfair text-2xl lg:text-3xl font-bold text-white mb-8">Upcoming Events</h3>
                    <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
                        <div class="bg-white/10 backdrop-blur rounded-xl p-6">
                            <div class="text-yellow-400 font-bold text-sm mb-2">DEC 20</div>
                            <h4 class="text-white font-bold mb-2">Winter Concert</h4>
                            <p class="text-gray-300 text-sm">7:00 PM - Auditorium</p>
                        </div>
                        <div class="bg-white/10 backdrop-blur rounded-xl p-6">
                            <div class="text-yellow-400 font-bold text-sm mb-2">JAN 8</div>
                            <h4 class="text-white font-bold mb-2">Open House</h4>
                            <p class="text-gray-300 text-sm">9:00 AM - Main Campus</p>
                        </div>
                        <div class="bg-white/10 backdrop-blur rounded-xl p-6">
                            <div class="text-yellow-400 font-bold text-sm mb-2">JAN 15</div>
                            <h4 class="text-white font-bold mb-2">Parent Workshop</h4>
                            <p class="text-gray-300 text-sm">6:30 PM - Library</p>
                        </div>
                        <div class="bg-white/10 backdrop-blur rounded-xl p-6">
                            <div class="text-yellow-400 font-bold text-sm mb-2">FEB 1</div>
                            <h4 class="text-white font-bold mb-2">Application Deadline</h4>
                            <p class="text-gray-300 text-sm">Fall 2025 Enrollment</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- CTA Section -->
        <section class="cta-section py-20 lg:py-32">
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <h2 class="font-playfair text-4xl lg:text-5xl font-bold text-white mb-6">
                    Ready to Join Our Community?
                </h2>
                <p class="text-gray-200 text-lg mb-10 max-w-2xl mx-auto">
                    Take the first step towards an exceptional education. Schedule a campus tour 
                    or begin your application today.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <button class="gradient-accent text-white px-10 py-4 rounded-full font-semibold text-lg hover:shadow-2xl transition-all transform hover:scale-105">
                        Start Application
                    </button>
                    <button class="bg-white text-slate-800 px-10 py-4 rounded-full font-semibold text-lg hover:bg-gray-100 transition-all">
                        <i class="fas fa-phone-alt mr-2"></i> Call Admissions
                    </button>
                </div>
            </div>
        </section>
        
        <!-- Contact Section -->
        <section id="contact" class="py-20 lg:py-32 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <span class="text-yellow-600 font-semibold tracking-wider uppercase text-sm">Get in Touch</span>
                    <h2 class="font-playfair text-4xl lg:text-5xl font-bold text-slate-800 mt-3 mb-6">
                        Contact Us
                    </h2>
                </div>
                
                <div class="grid lg:grid-cols-3 gap-8">
                    <!-- Contact Info Cards -->
                    <div class="bg-slate-50 rounded-2xl p-8 text-center card-hover">
                        <div class="w-16 h-16 gradient-primary rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fas fa-map-marker-alt text-white text-2xl"></i>
                        </div>
                        <h3 class="font-bold text-slate-800 text-xl mb-3">Visit Us</h3>
                        <p class="text-gray-600">
                            1234 Academy Drive<br>
                            Westbrook, CT 06498
                        </p>
                        <a href="#" class="inline-block mt-4 text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                            Get Directions <i class="fas fa-external-link-alt ml-1 text-sm"></i>
                        </a>
                    </div>
                    
                    <div class="bg-slate-50 rounded-2xl p-8 text-center card-hover">
                        <div class="w-16 h-16 gradient-primary rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fas fa-phone-alt text-white text-2xl"></i>
                        </div>
                        <h3 class="font-bold text-slate-800 text-xl mb-3">Call Us</h3>
                        <p class="text-gray-600">
                            Main Office: (555) 123-4567<br>
                            Admissions: (555) 123-4568
                        </p>
                        <p class="text-gray-500 text-sm mt-4">Mon - Fri: 8:00 AM - 5:00 PM</p>
                    </div>
                    
                    <div class="bg-slate-50 rounded-2xl p-8 text-center card-hover">
                        <div class="w-16 h-16 gradient-primary rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fas fa-envelope text-white text-2xl"></i>
                        </div>
                        <h3 class="font-bold text-slate-800 text-xl mb-3">Email Us</h3>
                        <p class="text-gray-600">
                            General: info@westbrookacademy.edu<br>
                            Admissions: admissions@westbrookacademy.edu
                        </p>
                        <a href="#" class="inline-block mt-4 text-blue-800 font-semibold hover:text-yellow-600 transition-colors">
                            Send Email <i class="fas fa-arrow-right ml-1"></i>
                        </a>
                    </div>
                </div>
                
                <!-- Map Placeholder -->
                <div class="mt-12 bg-slate-200 rounded-2xl h-80 flex items-center justify-center overflow-hidden">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2997.8468896741!2d-72.4501!3d41.2890!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNDHCsDE3JzIwLjQiTiA3MsKwMjcnMDAuNCJX!5e0!3m2!1sen!2sus!4v1620000000000!5m2!1sen!2sus"
                        class="w-full h-full rounded-2xl"
                        style="border:0;" 
                        allowfullscreen="" 
                        loading="lazy">
                    </iframe>
                </div>
            </div>
        </section>
        
        <!-- Footer -->
        <footer class="footer-gradient text-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
                <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-12">
                    <!-- About -->
                    <div>
                        <div class="flex items-center space-x-3 mb-6">
                            <div class="w-12 h-12 gradient-accent rounded-lg flex items-center justify-center">
                                <i class="fas fa-graduation-cap text-white text-xl"></i>
                            </div>
                            <div>
                                <h3 class="font-playfair font-bold text-xl">Westbrook</h3>
                                <p class="text-xs text-gray-400 -mt-1">Academy</p>
                            </div>
                        </div>
                        <p class="text-gray-400 mb-6">
                            Shaping tomorrow's leaders through excellence in education, 
                            character development, and innovative learning.
                        </p>
                        <div class="flex space-x-4">
                            <a href="#" class="w-10 h-10 bg-white/10 rounded-full flex items-center justify-center hover:bg-yellow-500 transition-colors">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#" class="w-10 h-10 bg-white/10 rounded-full flex items-center justify-center hover:bg-yellow-500 transition-colors">
                                <i class="fab fa-twitter"></i>
                            </a>
                            <a href="#" class="w-10 h-10 bg-white/10 rounded-full flex items-center justify-center hover:bg-yellow-500 transition-colors">
                                <i class="fab fa-instagram"></i>
                            </a>
                            <a href="#" class="w-10 h-10 bg-white/10 rounded-full flex items-center justify-center hover:bg-yellow-500 transition-colors">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Quick Links -->
                    <div>
                        <h4 class="font-bold text-lg mb-6">Quick Links</h4>
                        <ul class="space-y-3">
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">About Us</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Academic Programs</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Admissions</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Student Life</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Athletics</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Alumni</a></li>
                        </ul>
                    </div>
                    
                    <!-- Resources -->
                    <div>
                        <h4 class="font-bold text-lg mb-6">Resources</h4>
                        <ul class="space-y-3">
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Parent Portal</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Student Portal</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Academic Calendar</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Employment</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Give to Westbrook</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-yellow-400 transition-colors">Privacy Policy</a></li>
                        </ul>
                    </div>
                    
                    <!-- Newsletter -->
                    <div>
                        <h4 class="font-bold text-lg mb-6">Stay Connected</h4>
                        <p class="text-gray-400 mb-4">Subscribe to our newsletter for updates and announcements.</p>
                        <form class="space-y-3">
                            <input type="email" 
                                   placeholder="Your email address" 
                                   class="w-full px-4 py-3 rounded-lg bg-white/10 border border-white/20 text-white placeholder-gray-400 focus:border-yellow-500 transition-colors">
                            <button type="submit" class="w-full gradient-accent py-3 rounded-lg font-semibold hover:opacity-90 transition-opacity">
                                Subscribe
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Bottom Footer -->
                <div class="border-t border-white/10 mt-12 pt-8 flex flex-col md:flex-row justify-between items-center">
                    <p class="text-gray-400 text-sm">
                        © 2024 Westbrook Academy. All rights reserved.
                    </p>
                    <div class="flex space-x-6 mt-4 md:mt-0">
                        <a href="#" class="text-gray-400 text-sm hover:text-yellow-400 transition-colors">Terms of Use</a>
                        <a href="#" class="text-gray-400 text-sm hover:text-yellow-400 transition-colors">Privacy Policy</a>
                        <a href="#" class="text-gray-400 text-sm hover:text-yellow-400 transition-colors">Accessibility</a>
                    </div>
                </div>
            </div>
        </footer>
        
        <!-- Back to Top Button -->
        <button id="backToTop" 
                class="fixed bottom-8 right-8 w-12 h-12 gradient-accent rounded-full shadow-lg flex items-center justify-center text-white opacity-0 invisible transition-all duration-300 hover:scale-110 z-40">
            <i class="fas fa-arrow-up"></i>
        </button>

        <script>
            // Mobile Menu Toggle
            const menuBtn = document.getElementById('menuBtn');
            const closeMenu = document.getElementById('closeMenu');
            const mobileMenu = document.getElementById('mobileMenu');
            
            menuBtn.addEventListener('click', () => {
                mobileMenu.classList.add('active');
            });
            
            closeMenu.addEventListener('click', () => {
                mobileMenu.classList.remove('active');
            });
            
            // Close mobile menu when clicking on links
            mobileMenu.querySelectorAll('a').forEach(link => {
                link.addEventListener('click', () => {
                    mobileMenu.classList.remove('active');
                });
            });
            
            // Navbar Background on Scroll
            const navbar = document.getElementById('navbar');
            window.addEventListener('scroll', () => {
                if (window.scrollY > 100) {
                    navbar.classList.add('bg-slate-900/95', 'backdrop-blur-md', 'shadow-lg');
                } else {
                    navbar.classList.remove('bg-slate-900/95', 'backdrop-blur-md', 'shadow-lg');
                }
            });
            
            // Back to Top Button
            const backToTop = document.getElementById('backToTop');
            window.addEventListener('scroll', () => {
                if (window.scrollY > 500) {
                    backToTop.classList.remove('opacity-0', 'invisible');
                    backToTop.classList.add('opacity-100', 'visible');
                } else {
                    backToTop.classList.add('opacity-0', 'invisible');
                    backToTop.classList.remove('opacity-100', 'visible');
                }
            });
            
            backToTop.addEventListener('click', () => {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            });
            
            // Counter Animation
            const counters = document.querySelectorAll('.counter');
            const counterObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const counter = entry.target;
                        const target = parseInt(counter.getAttribute('data-target'));
                        const duration = 2000;
                        const step = target / (duration / 16);
                        let current = 0;
                        
                        const updateCounter = () => {
                            current += step;
                            if (current < target) {
                                counter.textContent = Math.floor(current);
                                requestAnimationFrame(updateCounter);
                            } else {
                                counter.textContent = target;
                            }
                        };
                        
                        updateCounter();
                        counterObserver.unobserve(counter);
                    }
                });
            }, { threshold: 0.5 });
            
            counters.forEach(counter => counterObserver.observe(counter));
            
            // Smooth Scroll for Navigation Links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
            
            // Form Submission
            const inquiryForm = document.getElementById('inquiryForm');
            inquiryForm.addEventListener('submit', (e) => {
                e.preventDefault();
                
                // Show success message (in production, this would submit to a server)
                const button = inquiryForm.querySelector('button[type="submit"]');
                const originalText = button.textContent;
                button.textContent = 'Submitted Successfully!';
                button.classList.add('bg-green-500');
                button.disabled = true;
                
                setTimeout(() => {
                    button.textContent = originalText;
                    button.classList.remove('bg-green-500');
                    button.disabled = false;
                    inquiryForm.reset();
                }, 3000);
            });
            
            // Animate elements on scroll
            const animateOnScroll = () => {
                const elements = document.querySelectorAll('.card-hover, .feature-card, .testimonial-card, .news-card');
                
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.style.opacity = '1';
                            entry.target.style.transform = 'translateY(0)';
                        }
                    });
                }, { threshold: 0.1 });
                
                elements.forEach(el => {
                    el.style.opacity = '0';
                    el.style.transform = 'translateY(30px)';
                    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    observer.observe(el);
                });
            };
            
            animateOnScroll();
        </script>
    </form>
</body>
</html>