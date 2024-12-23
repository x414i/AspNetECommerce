<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server">
                            <strong>
                            <asp:Label ID="Label2" runat="server" CssClass="auto-style1" Text="This Is Administrator Home Page"></asp:Label>
                            </strong>
                        </asp:Panel>
                    </asp:Content>


