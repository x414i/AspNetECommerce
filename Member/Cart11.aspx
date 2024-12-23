<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc1" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                            <br />
                            <br />
                            <uc1:Cart ID="Cart1" runat="server" />
                        </asp:Panel>
                    </asp:Content>


