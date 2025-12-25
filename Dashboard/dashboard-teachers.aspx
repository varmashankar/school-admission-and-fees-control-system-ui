<%@ Page Title="" Language="C#" MasterPageFile="~/Master/teachers.master" AutoEventWireup="true" CodeFile="dashboard-teachers.aspx.cs" Inherits="Dashboard_dashboard_teachers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            <main class="flex-1 p-6">
     <h1 class="text-2xl font-bold mb-4">Welcome, Teacher!</h1>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="bg-white shadow p-4 rounded">
                <i class="bi bi-calendar3 text-3xl text-green-600"></i>
                <h2 class="font-semibold mt-2">Today’s Classes</h2>
                <p class="text-gray-500">3 Scheduled</p>
            </div>
            <div class="bg-white shadow p-4 rounded">
                <i class="bi bi-journal-text text-3xl text-green-600"></i>
                <h2 class="font-semibold mt-2">Pending Assignments</h2>
                <p class="text-gray-500">5 Pending</p>
            </div>
        </div>
                </main>
</asp:Content>

