<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="events.aspx.cs" Inherits="Dashboard_admin_events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- Bootstrap CSS - Ensure this is not already in your Master Page -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style type="text/css">
        .event-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: flex-start;
        }
        .event-item:last-child {
            border-bottom: none;
        }
        .event-icon {
            font-size: 1.8em;
            margin-right: 15px;
            color: #007bff;
            min-width: 30px;
        }
        .event-content {
            flex-grow: 1;
        }
        .event-content h5 {
            margin-top: 0;
            margin-bottom: 5px;
        }
        .event-actions {
            margin-left: 15px;
            white-space: nowrap;
        }
        /* Styling for different event states */
        .event-upcoming .event-icon { color: #28a745; /* green */ }
        .event-current .event-icon { color: #007bff; /* blue */ }
        .event-past .event-icon { color: #6c757d; /* grey */ opacity: 0.7; }
        .event-past .event-content h5,
        .event-past .event-content p,
        .event-past .event-content small { color: #6c757d; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <h3 class="text-xl font-bold text-gray-800">Events</h3> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">
        <h2 class="mb-4">School Events</h2>

        <div class="card">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                Upcoming Events
                <button type="button" class="btn btn-sm btn-primary px-3" data-bs-toggle="modal" data-bs-target="#addEventModal" title="Add New Event">
                    <i class="fas fa-calendar-plus me-3"></i>Add Event
                </button>
            </div>
            <div class="card-body">
                <asp:UpdatePanel ID="upEvents" runat="server">
                    <ContentTemplate>
                        <div id="eventList" runat="server">
                            <%-- Example Event Items (will be replaced by dynamic data) --%>
                            <div class="event-item event-upcoming" data-event-id="1">
                                <i class="fas fa-calendar-check event-icon"></i>
                                <div class="event-content">
                                    <h5>Parent-Teacher Meeting</h5>
                                    <p class="mb-0"><strong>Date:</strong> Nov 15, 2023 | <strong>Time:</strong> 9:00 AM - 4:00 PM</p>
                                    <small class="text-muted">Main Auditorium</small>
                                </div>
                                <div class="event-actions">
                                    <button class="btn btn-sm btn-warning me-1" title="Edit Event" onclick="openEditEventModal('1'); return false;"><i class="fas fa-edit"></i></button>
                                    <asp:LinkButton ID="lnkDeleteEvent1" runat="server" CssClass="btn btn-sm btn-danger" ToolTip="Delete Event" CommandName="DeleteEvent" CommandArgument="1" OnCommand="HandleEventAction" OnClientClick="return confirm('Are you sure you want to delete this event?');"><i class="fas fa-trash-alt"></i></asp:LinkButton>
                                </div>
                            </div>
                            <div class="event-item event-upcoming" data-event-id="2">
                                <i class="fas fa-graduation-cap event-icon"></i>
                                <div class="event-content">
                                    <h5>Annual Sports Day</h5>
                                    <p class="mb-0"><strong>Date:</strong> Dec 1, 2023 | <strong>Time:</strong> All Day</p>
                                    <small class="text-muted">School Grounds</small>
                                </div>
                                <div class="event-actions">
                                    <button class="btn btn-sm btn-warning me-1" title="Edit Event" onclick="openEditEventModal('2'); return false;"><i class="fas fa-edit"></i></button>
                                    <asp:LinkButton ID="lnkDeleteEvent2" runat="server" CssClass="btn btn-sm btn-danger" ToolTip="Delete Event" CommandName="DeleteEvent" CommandArgument="2" OnCommand="HandleEventAction" OnClientClick="return confirm('Are you sure you want to delete this event?');"><i class="fas fa-trash-alt"></i></asp:LinkButton>
                                </div>
                            </div>
                            <div class="event-item event-past" data-event-id="3">
                                <i class="fas fa-book event-icon"></i>
                                <div class="event-content">
                                    <h5>Library Book Fair</h5>
                                    <p class="mb-0"><strong>Date:</strong> Oct 8 - Oct 10, 2023 | <strong>Time:</strong> 10:00 AM - 5:00 PM</p>
                                    <small class="text-muted">School Library</small>
                                </div>
                                <div class="event-actions">
                                    <button class="btn btn-sm btn-warning me-1" title="Edit Event" onclick="openEditEventModal('3'); return false;"><i class="fas fa-edit"></i></button>
                                    <asp:LinkButton ID="lnkDeleteEvent3" runat="server" CssClass="btn btn-sm btn-danger" ToolTip="Delete Event" CommandName="DeleteEvent" CommandArgument="3" OnCommand="HandleEventAction" OnClientClick="return confirm('Are you sure you want to delete this event?');"><i class="fas fa-trash-alt"></i></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <asp:Label ID="lblNoEvents" runat="server" Text="No upcoming events found." CssClass="text-muted" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Add New Event Modal -->
    <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="addEventModalLabel">Add New Event</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="upAddEvent" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="txtEventTitle" class="form-label">Event Title</label>
                                <asp:TextBox ID="txtEventTitle" runat="server" placeholder="Event Title" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtEventDescription" class="form-label">Description</label>
                                <asp:TextBox ID="txtEventDescription" runat="server" placeholder="Event Description" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="txtEventStartDate" class="form-label">Start Date</label>
                                    <asp:TextBox ID="txtEventStartDate" runat="server" TextMode="Date" CssClass="form-control" Required="true"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="txtEventEndDate" class="form-label">End Date (Optional)</label>
                                    <asp:TextBox ID="txtEventEndDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="txtEventStartTime" class="form-label">Start Time (Optional)</label>
                                    <asp:TextBox ID="txtEventStartTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="txtEventEndTime" class="form-label">End Time (Optional)</label>
                                    <asp:TextBox ID="txtEventEndTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="txtEventLocation" class="form-label">Location</label>
                                <asp:TextBox ID="txtEventLocation" runat="server" placeholder="Event Location" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="ddlEventAudience" class="form-label">Audience</label>
                                <asp:DropDownList ID="ddlEventAudience" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Students" Value="Students"></asp:ListItem>
                                    <asp:ListItem Text="Teachers" Value="Teachers"></asp:ListItem>
                                    <asp:ListItem Text="Parents" Value="Parents"></asp:ListItem>
                                    <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveEvent" runat="server" Text="Save Event" CssClass="btn btn-primary" OnClick="btnSaveEvent_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Event Modal (Reuse Add Event modal structure, or create a new one) -->
    <div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="editEventModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title" id="editEventModalLabel">Edit Event</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="upEditEvent" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <asp:HiddenField ID="hfEditEventId" runat="server" />
                            <div class="mb-3">
                                <label for="txtEditEventTitle" class="form-label">Event Title</label>
                                <asp:TextBox ID="txtEditEventTitle" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtEditEventDescription" class="form-label">Description</label>
                                <asp:TextBox ID="txtEditEventDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="txtEditEventStartDate" class="form-label">Start Date</label>
                                    <asp:TextBox ID="txtEditEventStartDate" runat="server" TextMode="Date" CssClass="form-control" Required="true"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="txtEditEventEndDate" class="form-label">End Date (Optional)</label>
                                    <asp:TextBox ID="txtEditEventEndDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="txtEditEventStartTime" class="form-label">Start Time (Optional)</label>
                                    <asp:TextBox ID="txtEditEventStartTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="txtEditEventEndTime" class="form-label">End Time (Optional)</label>
                                    <asp:TextBox ID="txtEditEventEndTime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="txtEditEventLocation" class="form-label">Location</label>
                                <asp:TextBox ID="txtEditEventLocation" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="ddlEditEventAudience" class="form-label">Audience</label>
                                <asp:DropDownList ID="ddlEditEventAudience" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Students" Value="Students"></asp:ListItem>
                                    <asp:ListItem Text="Teachers" Value="Teachers"></asp:ListItem>
                                    <asp:ListItem Text="Parents" Value="Parents"></asp:ListItem>
                                    <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdateEvent" runat="server" Text="Update Event" CssClass="btn btn-warning" OnClick="btnUpdateEvent_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            // Set current date as default for event start date on initial load
            const eventStartDateInput = document.getElementById('<%= txtEventStartDate.ClientID %>');
            if (eventStartDateInput && !eventStartDateInput.value) {
                const today = new Date();
                const year = today.getFullYear();
                const month = String(today.getMonth() + 1).padStart(2, '0');
                const day = String(today.getDate()).padStart(2, '0');
                eventStartDateInput.value = `${year}-${month}-${day}`;
            }
        });

        // Function to handle opening edit modal
        function openEditEventModal(eventId) {
            // You'll need to fetch event details from the server via AJAX (WebMethod or Page Method)
            // or perform a postback to populate the edit modal.
            // For now, this is a placeholder that triggers a server-side method for the UpdatePanel.

            // Set the HiddenField value
            const hfEditEventId = document.getElementById('<%= hfEditEventId.ClientID %>');
            if (hfEditEventId) {
                hfEditEventId.value = eventId;
            }

            // Trigger a partial postback to load the event data into the edit modal
            // We'll use a hidden button for this within the upEditEvent UpdatePanel
            __doPostBack('<%= btnLoadEventForEdit.ClientID %>', ''); // Pass no argument, or eventId
        }


        // Re-attach Bootstrap modal functionality after UpdatePanel updates
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function(sender, args) {
            if (args.get_error()) {
                args.set_errorHandled(true); // Prevent default ASP.NET error handling
            }

            // If the 'Add Event' modal was submitted, ensure it closes
            if (sender._postBackSettings.panelsToUpdate.includes('<%= upAddEvent.ClientID %>')) {
                 var addEventModal = bootstrap.Modal.getInstance(document.getElementById('addEventModal'));
                 if(addEventModal) {
                    addEventModal.hide();
                 }
            }

            // If the 'Edit Event' modal was prepared (e.g., after loading data), show it
            // This assumes your C# code will register a script to show the modal
            // if an event was successfully loaded for editing.
            // Alternatively, you can explicitly show it here if a specific trigger caused an update:
            // if (sender._postBackSettings.sourceElement && sender._postBackSettings.sourceElement.id === '<%= btnLoadEventForEdit.ClientID %>') {
            //      var editEventModal = new bootstrap.Modal(document.getElementById('editEventModal'));
            //      editEventModal.show();
            // }
        });
    </script>

    <%-- Hidden button to trigger postback for loading event details for edit modal --%>
    <asp:Button ID="btnLoadEventForEdit" runat="server" style="display:none;" OnClick="btnLoadEventForEdit_Click" />
</asp:Content>
