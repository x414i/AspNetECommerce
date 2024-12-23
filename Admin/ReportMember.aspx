<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" %>

<script runat="server">

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Member.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" />
                            <br />
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                        </asp:Panel>
                    </asp:Content>


