<%@ Control Language="C#" ClassName="WebUserControl" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        gdvCart.DataSource =  (DataTable)Session["items"];
        gdvCart.DataBind();

    
    }
</script>
<table align="center">
    <tr>
        <td>
            <asp:GridView ID="gdvCart" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:BoundField DataField="catno" HeaderText="رقم الصنف" ReadOnly="True" />
                    <asp:BoundField DataField="catname" HeaderText="Category name" ReadOnly="True" />
                    <asp:BoundField DataField="proid" HeaderText="Product Number" ReadOnly="True" />
                    <asp:BoundField DataField="proname" HeaderText="Product Name" ReadOnly="True" />
                    <asp:BoundField DataField="price" HeaderText="Price" ReadOnly="True" />
                    <asp:BoundField DataField="qty" HeaderText="Quantity" ReadOnly="True" />
                    <asp:BoundField DataField="subtotal" HeaderText="Sub Total" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Product Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval("proname") %>' Height="150px" ImageUrl='<%# "..\\Admin\\ProImage\\"+Eval("catno")+Eval("proid")+".jpg" %>' Width="150px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" HeaderText="Control" ShowDeleteButton="True" ShowEditButton="True" />
                </Columns>
                <EmptyDataTemplate>
                    The Shopping Cart Is Nothing , To Shop <a href="Categories.aspx"> Click Here</a>
                </EmptyDataTemplate>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                <SortedDescendingHeaderStyle BackColor="#3E3277" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td style="text-align: center">
            <asp:Label ID="Label1" runat="server" Text="TOTAL : "></asp:Label>
            <asp:Label ID="lblTotal" runat="server" Text=" 0"></asp:Label>
        </td>
    </tr>
</table>

