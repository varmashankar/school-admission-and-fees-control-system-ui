<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="messages.aspx.cs" Inherits="Dashboard_admin_messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- Bootstrap CSS - Ensure this is not already in your Master Page -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style type="text/css">
        .message-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: flex-start;
            cursor: pointer; /* Indicate clickable */
            transition: background-color 0.2s ease-in-out;
        }
        .message-item:hover {
            background-color: #f8f9fa;
        }
        .message-item:last-child {
            border-bottom: none;
        }
        .message-icon {
            font-size: 1.8em;
            margin-right: 15px;
            color: #007bff;
            min-width: 30px; /* Ensure icon doesn't shrink */
        }
        .message-content {
            flex-grow: 1;
        }
        .message-content h5 {
            margin-top: 0;
            margin-bottom: 5px;
        }
        .message-date {
            font-size: 0.85em;
            color: #6c757d;
            margin-left: auto;
            white-space: nowrap;
        }
        /* Styles for Read/Unread */
        .message-unread {
            font-weight: bold;
        }
        .message-unread .message-content h5 {
            color: #333;
        }
        .message-read .message-content h5,
        .message-read .message-content p {
            color: #6c757d;
        }
        .message-read .message-icon {
            color: #adb5bd; /* Lighter icon for read messages */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <h3 class="text-xl font-bold text-gray-800">Messages</h3> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">
        <h2 class="mb-4">Your Messages</h2>

        <div class="card">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                Inbox
                <div>
                    <button type="button" class="btn btn-sm btn-primary me-2" data-bs-toggle="modal" data-bs-target="#composeMessageModal" title="Compose New Message">
                        <i class="fas fa-plus me-1"></i>Compose
                    </button>
                    <asp:LinkButton ID="btnMarkAllRead" runat="server" CssClass="btn btn-sm btn-primary" OnClick="btnMarkAllRead_Click"
                        OnClientClick="return confirm('Are you sure you want to mark all messages as read?');"
                        ToolTip="Mark All as Read"><i class="fas fa-check-double me-1"></i>Mark All Read</asp:LinkButton>
                    <span class="badge bg-danger ms-2" id="unreadMessageCount" runat="server" Visible="false"></span>
                </div>
            </div>
            <div class="card-body">
                <asp:UpdatePanel ID="upMessages" runat="server">
                    <ContentTemplate>
                        <div id="messageList" runat="server">
                            <%-- Message items will be loaded here from code-behind --%>
                            <div class="message-item message-unread" data-message-id="1">
                                <i class="fas fa-bell message-icon"></i>
                                <div class="message-content">
                                    <h5>New Assignment Posted: Mathematics</h5>
                                    <p class="mb-0">A new assignment for Mathematics has been posted by Mr. Smith. Deadline: Nov 10, 2023.</p>
                                </div>
                                <span class="message-date">2 hours ago</span>
                            </div>
                            <div class="message-item message-unread" data-message-id="2">
                                <i class="fas fa-exclamation-triangle message-icon text-warning"></i>
                                <div class="message-content">
                                    <h5>System Maintenance Alert</h5>
                                    <p class="mb-0">The ERP system will undergo maintenance on Nov 5th from 1 AM to 3 AM.</p>
                                </div>
                                <span class="message-date">Yesterday</span>
                            </div>
                            <div class="message-item message-read" data-message-id="3">
                                <i class="fas fa-info-circle message-icon"></i>
                                <div class="message-content">
                                    <h5>Welcome to the New Term!</h5>
                                    <p class="mb-0">Greetings from the administration. We hope you have a productive new term.</p>
                                </div>
                                <span class="message-date">Oct 20, 2023</span>
                            </div>
                        </div>
                         <asp:Label ID="lblNoMessages" runat="server" Text="No messages found." CssClass="text-muted" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Compose New Message Modal -->
    <div class="modal fade" id="composeMessageModal" tabindex="-1" aria-labelledby="composeMessageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="composeMessageModalLabel">Compose New Message</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="upComposeMessage" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="txtMessageSubject" class="form-label">Subject</label>
                                <asp:TextBox ID="txtMessageSubject" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="ddlMessageRecipient" class="form-label">Recipient(s)</label>
                                <asp:DropDownList ID="ddlMessageRecipient" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Students" Value="Students"></asp:ListItem>
                                    <asp:ListItem Text="Teachers" Value="Teachers"></asp:ListItem>
                                    <asp:ListItem Text="Parents" Value="Parents"></asp:ListItem>
                                    <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                                    <%-- Add more recipients dynamically from your database --%>
                                </asp:DropDownList>
                                <small class="form-text text-muted">Select the target audience for this message.</small>
                            </div>
                             <div class="mb-3">
                                <label for="txtMessageContent" class="form-label">Message</label>
                                <asp:TextBox ID="txtMessageContent" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSendMessage" runat="server" Text="Send Message" CssClass="btn btn-primary" OnClick="btnSendMessage_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- View Message Detail Modal (Optional, but good for full message content) -->
    <div class="modal fade" id="viewMessageModal" tabindex="-1" aria-labelledby="viewMessageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="viewMessageModalLabel">Message Detail</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h4 id="messageDetailSubject" class="mb-3"></h4>
                    <p class="text-muted"><small>From: <span id="messageDetailSender"></span> | To: <span id="messageDetailRecipient"></span> | On: <span id="messageDetailTimestamp"></span></small></p>
                    <hr />
                    <div id="messageDetailContent"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        // Client-side script to handle message clicks and show detail modal
        function registerMessageClickHandlers() {
            document.querySelectorAll('#messageList .message-item').forEach(item => {
                // Remove existing handlers to prevent duplicates after UpdatePanel refresh
                item.removeEventListener('click', messageClickHandler);
                item.addEventListener('click', messageClickHandler);
            });
        }

        function messageClickHandler() {
            const messageId = this.dataset.messageId;
            if (messageId) {
                // Here, you would typically make an AJAX call to a WebMethod or Generic Handler
                // to fetch the full message content from the server using messageId
                // For this example, we'll use a placeholder.

                // Example: ASP.NET WebMethod call (requires [System.Web.Services.WebMethod] on your C# method)
                // PageMethods.GetMessageDetails(messageId, OnGetMessageDetailsSuccess, OnGetMessageDetailsFailure);

                // For now, let's just populate the modal with generic data
                // In a real app, you'd fetch subject, content, sender, recipient, timestamp from DB
                document.getElementById('messageDetailSubject').innerText = this.querySelector('h5').innerText;
                document.getElementById('messageDetailContent').innerHTML = this.querySelector('p').innerText; // Displaying short content for demo
                document.getElementById('messageDetailSender').innerText = "System"; // Replace with actual sender
                document.getElementById('messageDetailRecipient').innerText = "You"; // Replace with actual recipient
                document.getElementById('messageDetailTimestamp').innerText = this.querySelector('.message-date').innerText; // Use rendered date

                const viewMessageModal = new bootstrap.Modal(document.getElementById('viewMessageModal'));
                viewMessageModal.show();

                // Optionally, mark as read on click (visually and then via server call)
                if (this.classList.contains('message-unread')) {
                    this.classList.remove('message-unread');
                    this.classList.add('message-read');
                    const unreadCountBadge = document.getElementById('<%= unreadMessageCount.ClientID %>');
                    if (unreadCountBadge) {
                        let currentCount = parseInt(unreadCountBadge.innerText);
                        if (!isNaN(currentCount) && currentCount > 0) {
                            unreadCountBadge.innerText = (currentCount - 1).toString();
                            if ((currentCount - 1) === 0) {
                                unreadCountBadge.style.display = 'none'; // Hide if no unread
                            }
                        }
                    }
                    // Trigger server-side mark as read
                    
                }
            }
        }

        // Register handlers on initial page load
        document.addEventListener('DOMContentLoaded', registerMessageClickHandlers);

        // Register handlers after every UpdatePanel AJAX request completes
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function(sender, args) {
            registerMessageClickHandlers(); // Re-attach handlers to new/updated message items
            if (args.get_error()) {
                args.set_errorHandled(true); // Prevent default ASP.NET error handling
            }
            // If the compose message modal was submitted, ensure it closes
            if (sender._postBackSettings.panelsToUpdate.includes('<%= upComposeMessage.ClientID %>')) {
                 var composeMessageModal = bootstrap.Modal.getInstance(document.getElementById('composeMessageModal'));
                 if(composeMessageModal) {
                    composeMessageModal.hide();
                 }
            }
        });
    </script>
</asp:Content>
