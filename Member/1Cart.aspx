<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Member/MemberMaster.master" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc1" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server" style="text-align: center">
                            <strong>
                            <asp:Label ID="Label2" runat="server" CssClass="auto-style1" Font-Names="cairo" Font-Overline="False" Font-Underline="False" Text="عربة التسوق" Font-Bold="True" Font-Size="24pt"></asp:Label>
                            <br />
                            <br />
                            <uc1:Cart ID="Cart1" runat="server" />
                            </strong>
                        </asp:Panel>
                    </asp:Content>


