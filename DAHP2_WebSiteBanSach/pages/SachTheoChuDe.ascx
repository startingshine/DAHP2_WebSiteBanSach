<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SachTheoChuDe.ascx.cs" Inherits="DAHP2_WebSiteBanSach.pages.SachTheoChuDe" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
.tab-container {
    display: flex;
    gap: 12px;
    margin-bottom: 15px;
}
.tab-item {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #f8f8f8;
    cursor: pointer;
    transition: all 0.3s;
}
.tab-item:hover {
    background-color: #e53935;
    color: #fff;
}
.tab-item.active {
    background-color: #d32f2f;
    color: #fff;
    border-color: #d32f2f;
}
.book-list {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
}
.book-item {
    width: 160px;
    text-align: center;
}
.book-item img {
    width: 100%;
    height: 220px;
    object-fit: cover;
    border-radius: 6px;
}
.price {
    color: #d32f2f;
    font-weight: bold;
    margin-top: 5px;
}
.btn-more {
    padding: 6px 16px;
    border: none;
    background-color: #1976d2;
    color: white;
    border-radius: 6px;
    cursor: pointer;
}
.btn-more:hover {
    background-color: #0d47a1;
}
</style>

<!-- AJAX UpdatePanel bắt đầu -->
<asp:UpdatePanel ID="UpdatePanelSach" runat="server">
    <ContentTemplate>
        <!-- Tabs chủ đề -->
        <div class="tab-container">
            <asp:Repeater ID="rptTabs" runat="server" OnItemCommand="rptTabs_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton runat="server" CommandName="SelectTab" CommandArgument='<%# Eval("MaChuDe") %>'
                        CssClass='<%# "tab-item " + (Eval("MaChuDe").ToString() == ViewState["MaChuDe"]?.ToString() ? "active" : "") %>'>
                        <%# Eval("TenChuDe") %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Danh sách sách -->
        <div class="book-list">
            <asp:Repeater ID="rptBooks" runat="server">
                <ItemTemplate>
                    <div class="book-item">
                        <ItemTemplate>
                            <asp:Image ID="imgHinhAnh" runat="server"
                            ImageUrl='<%# ResolveUrl("~/" + Eval("HinhAnh")) %>'
                            Width="100px" Height="100px" />
                        </ItemTemplate>
                        <h4><%# Eval("TenSach") %></h4>
                        <div class="price"><%# string.Format("{0:N0} đ", Eval("GiaBan")) %></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Nút xem thêm -->
        <div style="text-align:center; margin-top:10px;">
            <asp:Button ID="btnViewMore" runat="server" Text="Xem thêm" CssClass="btn-more" OnClick="btnViewMore_Click" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>