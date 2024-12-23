<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>

<%@ Register src="W.ascx" tagname="W" tagprefix="uc1" %>

<%@ Register src="W.ascx" tagname="W" tagprefix="uc2" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                            <br />
                            <uc2:W ID="W1" runat="server" />
                            <br />
                            <br />
                        </asp:Panel>
                    </asp:Content>


