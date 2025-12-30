<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeFile="inquiry-create.aspx.cs" Inherits="Dashboard_admin_inquiry_create" MasterPageFile="~/Master/admin.master" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="Server">
    <style>
        .form-card {
            background: #ffffff;
            border: 1px solid rgba(0,0,0,.06);
            border-radius: .75rem;
            padding: 1.25rem;
        }

        .form-card .form-label {
            margin-bottom: .25rem;
            font-size: .8rem;
            color: #374151;
            font-weight: 500;
        }

        .hint {
            font-size: .75rem;
            color: #6b7280;
            margin-top: .25rem;
        }

        input[type="date"].form-control,
        input[type="datetime-local"].form-control {
            min-height: 40px;
        }

        /* Section styling */
        .form-section {
            margin-bottom: 1.5rem;
        }

        .form-section-title {
            display: flex;
            align-items: center;
            gap: .5rem;
            margin-bottom: 1rem;
            padding-bottom: .5rem;
            border-bottom: 2px solid #e5e7eb;
        }

        .form-section-title i {
            color: #6366f1;
            font-size: 1.1rem;
        }

        .form-section-title span {
            font-weight: 600;
            color: #1f2937;
            font-size: .95rem;
        }

        /* Admin section styling */
        .admin-section {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            border: 1px solid #f59e0b;
            border-radius: .5rem;
            padding: 1rem;
            margin-top: 1rem;
        }

        .admin-section .form-section-title {
            border-bottom-color: #f59e0b;
        }

        .admin-section .form-section-title i {
            color: #d97706;
        }

        /* Input focus states */
        .form-control:focus,
        .form-select:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        /* Validation styles */
        .form-control.is-invalid,
        .form-select.is-invalid {
            border-color: #dc3545;
            background-image: none;
        }

        .form-control.is-valid,
        .form-select.is-valid {
            border-color: #198754;
            background-image: none;
        }

        .invalid-feedback {
            font-size: .75rem;
        }

        /* Button loading state */
        .btn-loading {
            position: relative;
            pointer-events: none;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            width: 1rem;
            height: 1rem;
            top: 50%;
            left: 50%;
            margin-left: -0.5rem;
            margin-top: -0.5rem;
            border: 2px solid transparent;
            border-top-color: currentColor;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }

        .btn-loading span,
        .btn-loading i {
            visibility: hidden;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Quick actions tip cards */
        .tip-card {
            background: #f0fdf4;
            border: 1px solid #86efac;
            border-radius: .5rem;
            padding: .75rem;
            margin-bottom: .75rem;
        }

        .tip-card.tip-info {
            background: #eff6ff;
            border-color: #93c5fd;
        }

        .tip-card.tip-warning {
            background: #fffbeb;
            border-color: #fcd34d;
        }

        .tip-card-title {
            font-size: .8rem;
            font-weight: 600;
            color: #166534;
            margin-bottom: .25rem;
            display: flex;
            align-items: center;
            gap: .35rem;
        }

        .tip-card.tip-info .tip-card-title {
            color: #1e40af;
        }

        .tip-card.tip-warning .tip-card-title {
            color: #92400e;
        }

        .tip-card-text {
            font-size: .75rem;
            color: #4b5563;
            margin: 0;
        }

        /* Character counter */
        .char-counter {
            font-size: .7rem;
            color: #9ca3af;
            text-align: right;
            margin-top: .25rem;
        }

        .char-counter.warning {
            color: #f59e0b;
        }

        .char-counter.danger {
            color: #dc3545;
        }

        /* Source dropdown styling */
        .source-options {
            display: flex;
            flex-wrap: wrap;
            gap: .5rem;
            margin-top: .5rem;
        }

        .source-option {
            padding: .35rem .75rem;
            font-size: .75rem;
            border: 1px solid #d1d5db;
            border-radius: 2rem;
            background: #fff;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .source-option:hover {
            border-color: #6366f1;
            background: #eef2ff;
        }

        .source-option.active {
            border-color: #6366f1;
            background: #6366f1;
            color: #fff;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .form-card {
                padding: 1rem;
            }
        }

        /* Progress indicator - FIXED alignment */
        .form-progress {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            position: relative;
            padding: 0 2rem;
        }

        .form-progress::before {
            content: '';
            position: absolute;
            top: 16px;
            left: 2rem;
            right: 2rem;
            height: 2px;
            background: #e5e7eb;
            z-index: 0;
        }

        .progress-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 1;
            flex: 1;
        }

        .progress-step:first-child {
            align-items: flex-start;
        }

        .progress-step:last-child {
            align-items: flex-end;
        }

        .progress-step-circle {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: .8rem;
            font-weight: 600;
            color: #9ca3af;
            transition: all 0.3s ease;
        }

        .progress-step.active .progress-step-circle {
            border-color: #6366f1;
            background: #6366f1;
            color: #fff;
        }

        .progress-step.completed .progress-step-circle {
            border-color: #10b981;
            background: #10b981;
            color: #fff;
        }

        .progress-step-label {
            font-size: .7rem;
            color: #6b7280;
            margin-top: .35rem;
            text-align: center;
        }

        .progress-step:first-child .progress-step-label {
            text-align: left;
        }

        .progress-step:last-child .progress-step-label {
            text-align: right;
        }

        .progress-step.active .progress-step-label {
            color: #6366f1;
            font-weight: 600;
        }

        .progress-step.completed .progress-step-label {
            color: #10b981;
        }

        /* Sidebar - align to top and sticky on scroll */
        .sidebar-tips-wrapper {
            position: relative;
        }

        .sidebar-tips {
            transition: transform 0.1s ease-out;
        }

        .sidebar-tips.is-sticky {
            position: fixed;
            top: 70px;
            width: inherit;
            max-width: inherit;
            z-index: 100;
        }

        /* Placeholder to prevent content jump when sidebar becomes fixed */
        .sidebar-placeholder {
            display: none;
        }

        .sidebar-placeholder.active {
            display: block;
        }

        @media (max-width: 991.98px) {
            .sidebar-tips.is-sticky {
                position: relative;
                top: 0;
                width: auto;
                max-width: none;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    <div class="d-flex align-items-center justify-content-between w-100">
        <div class="d-flex align-items-center gap-3">
            <%--<a href="inquiries.aspx" class="btn btn-light btn-sm d-flex align-items-center gap-1" title="Back to Inquiries">
                <i class="bi bi-arrow-left"></i>
                <span class="d-none d-sm-inline">Back</span>
            </a>--%>
            <div class="d-flex flex-column">
                <h5 class="m-0">Create Inquiry</h5>
                <span class="text-muted small d-none d-md-block">Capture lead details for the admission process</span>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row g-3 align-items-start">
            <div class="col-12 col-lg-8">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <!-- Progress Indicator -->
                        <div class="form-progress d-none d-md-flex">
                            <div class="progress-step active" id="step1">
                                <div class="progress-step-circle">1</div>
                                <div class="progress-step-label">Contact Info</div>
                            </div>
                            <div class="progress-step" id="step2">
                                <div class="progress-step-circle">2</div>
                                <div class="progress-step-label">Academic</div>
                            </div>
                            <div class="progress-step" id="step3">
                                <div class="progress-step-circle">3</div>
                                <div class="progress-step-label">Details</div>
                            </div>
                        </div>

                        <div class="form-card">
                            <!-- Section 1: Contact Information -->
                            <div class="form-section">
                                <div class="form-section-title">
                                    <i class="bi bi-person-vcard"></i>
                                    <span>Contact Information</span>
                                </div>
                                <div class="row g-3">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="txtFirstName">First Name <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="Enter first name" MaxLength="50" />
                                        <div class="invalid-feedback">Please enter the first name.</div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="txtLastName">Last Name <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Enter last name" MaxLength="50" />
                                        <div class="invalid-feedback">Please enter the last name.</div>
                                    </div>

                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="txtPhone">Phone Number <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="10-digit mobile number" MaxLength="10" />
                                        </div>
                                        <div class="hint">Enter 10-digit mobile number without country code</div>
                                        <div class="invalid-feedback">Please enter a valid 10-digit phone number.</div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="txtEmail">Email Address <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@example.com" TextMode="Email" MaxLength="100" />
                                        </div>
                                        <div class="invalid-feedback">Please enter a valid email address.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Section 2: Academic Interest -->
                            <div class="form-section">
                                <div class="form-section-title">
                                    <i class="bi bi-mortarboard"></i>
                                    <span>Academic Interest</span>
                                </div>
                                <div class="row g-3">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="ddlClass">Class Interested In <span class="text-danger">*</span></label>
                                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select" />
                                        <div class="invalid-feedback">Please select a class.</div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="ddlStream">Stream <span class="text-danger">*</span></label>
                                        <asp:DropDownList ID="ddlStream" runat="server" CssClass="form-select" />
                                        <div class="invalid-feedback">Please select a stream.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Section 3: Lead Source -->
                            <div class="form-section">
                                <div class="form-section-title">
                                    <i class="bi bi-signpost-2"></i>
                                    <span>Lead Source</span>
                                </div>
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label" for="txtSource">How did they hear about us? <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtSource" runat="server" CssClass="form-control" placeholder="Select or type a source" MaxLength="50" />
                                        <div class="source-options">
                                            <span class="source-option" onclick="setSource(this, 'WALKIN')">🚶 Walk-in</span>
                                            <span class="source-option" onclick="setSource(this, 'WEBSITE')">🌐 Website</span>
                                            <span class="source-option" onclick="setSource(this, 'REFERRAL')">👥 Referral</span>
                                            <span class="source-option" onclick="setSource(this, 'SOCIAL_MEDIA')">📱 Social Media</span>
                                            <span class="source-option" onclick="setSource(this, 'ADVERTISEMENT')">📢 Advertisement</span>
                                            <span class="source-option" onclick="setSource(this, 'OTHER')">📝 Other</span>
                                        </div>
                                        <div class="invalid-feedback">Please specify the lead source.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Admin-only Section -->
                            <div class="admin-section">
                                <div class="form-section-title">
                                    <i class="bi bi-shield-lock"></i>
                                    <span>Admin-only Fields</span>
                                </div>
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label" for="txtNotes">Internal Notes</label>
                                        <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" 
                                            placeholder="Add any relevant notes about this inquiry..." MaxLength="500" 
                                            onkeyup="updateCharCount(this, 500)" />
                                        <div class="char-counter" id="notesCounter">0 / 500 characters</div>
                                        <div class="hint">These notes are only visible to staff members.</div>
                                    </div>

                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="txtNextFollowUpAt">Schedule Follow-up</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-calendar-event"></i></span>
                                            <asp:TextBox ID="txtNextFollowUpAt" runat="server" CssClass="form-control" TextMode="DateTimeLocal" />
                                        </div>
                                        <div class="hint">Set a reminder for the next follow-up call.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2 flex-wrap mt-4 pt-3 border-top">
                                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary px-4" OnClick="btnSave_Click" OnClientClick="return validateAndSubmit(this);">
                                    <i class="bi bi-check2-circle me-1"></i><span>Save Inquiry</span>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSaveAndNew" runat="server" CssClass="btn btn-outline-primary" OnClick="btnSaveAndNew_Click" OnClientClick="return validateAndSubmit(this);">
                                    <i class="bi bi-plus-circle me-1"></i><span>Save & Create Another</span>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnClear_Click" CausesValidation="false">
                                    <i class="bi bi-x-circle me-1"></i>Clear Form
                                </asp:LinkButton>
                            </div>

                            <div class="col-12 mt-3">
                                <asp:Label ID="lblInfo" runat="server" CssClass="text-muted small" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar Tips - Fixed alignment -->
            <div class="col-12 col-lg-4 sidebar-tips-wrapper">
                <div class="sidebar-placeholder"></div>
                <div class="card shadow-sm border-0 sidebar-tips" id="sidebarTips">
                    <div class="card-body">
                        <div class="fw-semibold mb-3 d-flex align-items-center gap-2">
                            <i class="bi bi-lightbulb text-warning"></i>
                            Quick Tips
                        </div>

                        <div class="tip-card tip-info">
                            <div class="tip-card-title">
                                <i class="bi bi-info-circle"></i>
                                Required Fields
                            </div>
                            <p class="tip-card-text">Fields marked with <span class="text-danger">*</span> are mandatory. Complete all required fields before saving.</p>
                        </div>

                        <div class="tip-card">
                            <div class="tip-card-title">
                                <i class="bi bi-telephone"></i>
                                Follow-up Scheduling
                            </div>
                            <p class="tip-card-text">Set a follow-up date to receive reminders. Default is set to tomorrow.</p>
                        </div>

                        <div class="tip-card tip-warning">
                            <div class="tip-card-title">
                                <i class="bi bi-exclamation-triangle"></i>
                                Duplicate Check
                            </div>
                            <p class="tip-card-text">The system will check for existing inquiries with the same phone or email.</p>
                        </div>

                        <hr class="my-3" />

                        <div class="fw-semibold mb-2 small">Quick Actions</div>
                        <div class="d-grid gap-2">
                            <a href="inquiries.aspx" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-list-ul me-1"></i>View All Inquiries
                            </a>
                            <a href="inquiry-followups.aspx" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-clock-history me-1"></i>Pending Follow-ups
                            </a>
                        </div>

                        <hr class="my-3" />

                        <div class="small text-muted">
                            <div class="fw-semibold mb-2">Keyboard Shortcuts</div>
                            <div class="d-flex align-items-center justify-content-between mb-1">
                                <div><kbd>Ctrl</kbd> + <kbd>S</kbd></div>
                                <span class="text-end">Save</span>
                            </div>
                            <div class="d-flex align-items-center justify-content-between">
                                <div><kbd>Esc</kbd></div>
                                <span class="text-end">Clear form</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Source selection handler
        function setSource(element, value) {
            document.querySelectorAll('.source-option').forEach(el => el.classList.remove('active'));
            element.classList.add('active');
            document.getElementById('<%= txtSource.ClientID %>').value = value;
            validateField(document.getElementById('<%= txtSource.ClientID %>'));
        }

        // Character counter for notes
        function updateCharCount(textarea, maxLength) {
            const counter = document.getElementById('notesCounter');
            const currentLength = textarea.value.length;
            counter.textContent = currentLength + ' / ' + maxLength + ' characters';
            
            counter.classList.remove('warning', 'danger');
            if (currentLength > maxLength * 0.9) {
                counter.classList.add('danger');
            } else if (currentLength > maxLength * 0.7) {
                counter.classList.add('warning');
            }
        }

        // Field validation
        function validateField(field) {
            const value = field.value.trim();
            const isRequired = field.closest('.col-12, .col-md-6')?.querySelector('.text-danger');
            
            if (isRequired && !value) {
                field.classList.add('is-invalid');
                field.classList.remove('is-valid');
                return false;
            }

            // Email validation
            if (field.type === 'email' && value) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    field.classList.add('is-invalid');
                    field.classList.remove('is-valid');
                    return false;
                }
            }

            // Phone validation (10 digits)
            if (field.id === '<%= txtPhone.ClientID %>' && value) {
                const phoneRegex = /^[0-9]{10}$/;
                if (!phoneRegex.test(value)) {
                    field.classList.add('is-invalid');
                    field.classList.remove('is-valid');
                    return false;
                }
            }

            if (value) {
                field.classList.remove('is-invalid');
                field.classList.add('is-valid');
            } else {
                field.classList.remove('is-invalid', 'is-valid');
            }
            return true;
        }

        // Update progress indicator
        function updateProgress() {
            const firstName = document.getElementById('<%= txtFirstName.ClientID %>').value.trim();
            const lastName = document.getElementById('<%= txtLastName.ClientID %>').value.trim();
            const phone = document.getElementById('<%= txtPhone.ClientID %>').value.trim();
            const email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            const classVal = document.getElementById('<%= ddlClass.ClientID %>').value;
            const streamVal = document.getElementById('<%= ddlStream.ClientID %>').value;
            const source = document.getElementById('<%= txtSource.ClientID %>').value.trim();

            const step1 = document.getElementById('step1');
            const step2 = document.getElementById('step2');
            const step3 = document.getElementById('step3');

            // Step 1: Contact Info
            if (firstName && lastName && phone && email) {
                step1.classList.add('completed');
                step2.classList.add('active');
            } else {
                step1.classList.remove('completed');
                step2.classList.remove('active', 'completed');
                step3.classList.remove('active', 'completed');
            }

            // Step 2: Academic
            if (step1.classList.contains('completed') && classVal && streamVal) {
                step2.classList.add('completed');
                step3.classList.add('active');
            } else if (!step1.classList.contains('completed')) {
                step2.classList.remove('active', 'completed');
            }

            // Step 3: Details
            if (step2.classList.contains('completed') && source) {
                step3.classList.add('completed');
            } else {
                step3.classList.remove('completed');
            }
        }

        // Form validation before submit
        function validateAndSubmit(btn) {
            let isValid = true;
            const requiredFields = [
                '<%= txtFirstName.ClientID %>',
                '<%= txtLastName.ClientID %>',
                '<%= txtPhone.ClientID %>',
                '<%= txtEmail.ClientID %>',
                '<%= ddlClass.ClientID %>',
                '<%= ddlStream.ClientID %>',
                '<%= txtSource.ClientID %>'
            ];

            requiredFields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                if (!validateField(field)) {
                    isValid = false;
                }
            });

            if (!isValid) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Incomplete Form',
                    text: 'Please fill in all required fields correctly.',
                    confirmButtonColor: '#6366f1'
                });
                return false;
            }

            // Add loading state
            btn.classList.add('btn-loading');
            return true;
        }

        // Phone input - only allow numbers
        document.getElementById('<%= txtPhone.ClientID %>').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);
            validateField(this);
            updateProgress();
        });

        // Add blur validation to all inputs
        document.querySelectorAll('.form-control, .form-select').forEach(field => {
            field.addEventListener('blur', function() {
                validateField(this);
            });
            field.addEventListener('input', function() {
                updateProgress();
            });
            field.addEventListener('change', function() {
                updateProgress();
            });
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl + S to save
            if (e.ctrlKey && e.key === 's') {
                e.preventDefault();
                document.getElementById('<%= btnSave.ClientID %>').click();
            }
            // Escape to clear
            if (e.key === 'Escape') {
                document.getElementById('<%= btnClear.ClientID %>').click();
            }
        });

        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateProgress();
            
            // Set initial source if exists
            const sourceField = document.getElementById('<%= txtSource.ClientID %>');
            if (sourceField.value) {
                document.querySelectorAll('.source-option').forEach(el => {
                    if (el.textContent.includes(sourceField.value) || el.onclick.toString().includes(sourceField.value)) {
                        el.classList.add('active');
                    }
                });
            }

            // Sticky sidebar handling
            initStickySidebar();
        });

        // Sticky sidebar functionality
        function initStickySidebar() {
            const sidebar = document.getElementById('sidebarTips');
            const wrapper = document.querySelector('.sidebar-tips-wrapper');
            const placeholder = document.querySelector('.sidebar-placeholder');
            
            // Find the scroll container - it's the main element with overflow-auto
            const scrollContainer = document.querySelector('main.flex-grow-1.overflow-auto');
            
            if (!sidebar || !wrapper || !scrollContainer) return;

            let sidebarWidth = sidebar.offsetWidth;
            const headerHeight = 70;

            function handleScroll() {
                // Skip on mobile/tablet
                if (window.innerWidth < 992) {
                    sidebar.classList.remove('is-sticky');
                    placeholder.classList.remove('active');
                    sidebar.style.width = '';
                    return;
                }

                const wrapperRect = wrapper.getBoundingClientRect();
                
                // Check if wrapper has scrolled past the header
                if (wrapperRect.top <= headerHeight) {
                    if (!sidebar.classList.contains('is-sticky')) {
                        sidebarWidth = sidebar.offsetWidth;
                        placeholder.style.height = sidebar.offsetHeight + 'px';
                        sidebar.style.width = sidebarWidth + 'px';
                        sidebar.classList.add('is-sticky');
                        placeholder.classList.add('active');
                    }
                } else {
                    sidebar.classList.remove('is-sticky');
                    placeholder.classList.remove('active');
                    sidebar.style.width = '';
                }
            }

            // Listen to scroll on the main container
            scrollContainer.addEventListener('scroll', handleScroll, { passive: true });

            // Handle window resize
            window.addEventListener('resize', function() {
                if (window.innerWidth < 992) {
                    sidebar.classList.remove('is-sticky');
                    placeholder.classList.remove('active');
                    sidebar.style.width = '';
                } else if (sidebar.classList.contains('is-sticky')) {
                    sidebarWidth = wrapper.offsetWidth;
                    sidebar.style.width = sidebarWidth + 'px';
                }
            }, { passive: true });

            // Initial check
            handleScroll();
        }
    </script>
</asp:Content>
