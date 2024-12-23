<%@ Page Title="" Language="C#" MasterPageFile="~/Member/MemberMaster.master" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        
        SqlDataSource1.ConnectionString = "Data Source=DESKTOP-J4JJ3J7\\SQLEXPRESS;Initial Catalog=COMPANY;Integrated Security=True;";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <asp:Panel ID="Panel1" runat="server" style="text-align: center">
        <strong style="text-align: center">
            <asp:Label ID="Label2" runat="server" Text="الاصناف" CssClass="auto-style1" Font-Names="cairo" Font-Overline="False" Font-Underline="False" Font-Bold="True" Font-Size="24pt"></asp:Label>
            <br />
            <br />
        </strong>
        <table align="center">
            <tr>
                <td>
                    <asp:DataList ID="DataList1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyField="catno" DataSourceID="SqlDataSource1" GridLines="Horizontal" RepeatColumns="3" RepeatDirection="Horizontal">
                        <AlternatingItemStyle BackColor="#F7F7F7" />
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <ItemStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <ItemTemplate>
                            <table align="center" style="width: 200px; border: 1px solid black;">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" style="font-weight: 700" Text="Category Name"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCatName" runat="server" style="font-weight: 700" Text='<%# Eval("catname") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="CatPro.aspx?catnum=<%# Eval("catno") %>&catname=<%# Eval("catname") %>">
                                        <asp:Image ID="imgCat" runat="server" AlternateText='<%# Eval("catname") %>' Height="200px" ImageUrl='<%# "..\\Admin\\CatImage\\"+Eval("catno")+".jpg" %>' Width="200px" />
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label4" runat="server" style="font-weight: 700" Text="Description"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCatDesc" runat="server" style="font-weight: 700" Text='<%# Eval("description") %>'></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <br />
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:COMPANYConnectionString1 %>" SelectCommand="SELECT [catno], [catname], [description] FROM [category]"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
