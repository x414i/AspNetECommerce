<%@ Control Language="C#" ClassName="Cart"  %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<style type="text/css">
    .auto-style1 {
        text-align: center;
    }
</style>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        grdCart.DataSource = (DataTable)Session["items"];
        grdCart.DataBind();
        double Sum = 0;
        for (int x=0; x < grdCart.Rows.Count; x++){
            Sum +=Convert.ToDouble( grdCart.Rows[x].Cells[6].Text);
            lblTotal.Text = Sum+" DLY";
        }

    }

    protected void grdCart_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
</script>
<table align="center">
    <tr>
        <td>
            <asp:GridView ID="grdCart" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" OnRowEditing="grdCart_RowEditing" AutoGenerateColumns="False" OnSelectedIndexChanged="grdCart_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:BoundField DataField="catno" HeaderText="Category Number" ReadOnly="True" />
                    <asp:BoundField DataField="catname" HeaderText="Category Name" ReadOnly="True" />
                    <asp:BoundField DataField="proid" HeaderText="Product Number" ReadOnly="True" />
                    <asp:BoundField DataField="proname" HeaderText="Product Name" ReadOnly="True" />
                    <asp:BoundField DataField="price" HeaderText="Price" ReadOnly="True" />
                    <asp:BoundField DataField="qty" HeaderText="Quantity" />
                    <asp:BoundField DataField="subtotal" HeaderText="Sub Total" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Product Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval("proname") %>' Height="98px" ImageUrl='<%# "..\\Admin\\ProImage\\"+Eval("catno")+Eval("proid")+".jpg" %>' Width="82px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" HeaderText="Control" ShowDeleteButton="True" ShowEditButton="True" >
                    <HeaderStyle Width="160px" />
                    </asp:CommandField>
                </Columns>
                <EmptyDataTemplate>
                    The Shopping Cart is Nothing. To Shop <a href="Categories.aspx">Click Here</a>
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
        <td class="auto-style1">
            <asp:Label ID="Label1" runat="server" Text="Total :"></asp:Label>
            <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
        </td>
    </tr>
</table>

