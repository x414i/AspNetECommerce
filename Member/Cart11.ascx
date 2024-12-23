<%@ Control Language="C#" ClassName="WebUserControl" %>

<style type="text/css">
    .auto-style2 {
        width: 5px;
    }
    .auto-style3 {
        text-align: center;
    }
</style>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>
<table align="center">
    <tr>
        <td>&nbsp;</td>
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="ddvCart" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:BoundField DataField="catno" HeaderText="Category Number" ReadOnly="True" />
                    <asp:BoundField DataField="catname" HeaderText="Category Name" ReadOnly="True" />
                    <asp:BoundField DataField="proid" HeaderText="Product Number" ReadOnly="True" />
                    <asp:BoundField DataField="proname" HeaderText="Prouduct Name" ReadOnly="True" />
                    <asp:BoundField DataField="price" HeaderText="Price" ReadOnly="True" />
                    <asp:BoundField DataField="qty" HeaderText="Quantity" />
                    <asp:BoundField DataField="subtotal" HeaderText="Sub Total" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Product Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval("proname") %>' Height="90px" ImageUrl='<%# "..\\Admin\\ProImage\\"+Eval("catno")+Eval("proid")+".jpg" %>' Width="90px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" HeaderText="Control" ShowDeleteButton="True" ShowEditButton="True" />
                </Columns>
                <EmptyDataTemplate>
                    <strong>The Shopping Cart is Nothing,To Shop <a href="Categories.aspx"> Click Here</a></strong>
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
        <td class="auto-style2">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style3">
            <asp:Label ID="lblTotal" runat="server"></asp:Label>
        </td>
        <td class="auto-style2">&nbsp;</td>
    </tr>
</table>

