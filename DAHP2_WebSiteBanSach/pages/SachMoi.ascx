<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SachMoi.ascx.cs" Inherits="DAHP2_WebSiteBanSach.pages.SachMoi" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
.sachmoi-container {
    width: 100%;
    margin: 20px;
    position: relative;
}

.book-list {
    display: flex;
    flex-wrap: nowrap;
    overflow: hidden;
    gap: 16px;
    transition: all 0.5s ease-in-out;
}

.book-item {
    flex: 0 0 calc(25% - 16px);
    text-align: left;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 10px;
    transition: transform 0.3s;
    cursor: pointer;
}
.book-item:hover {
    transform: translateY(-5px);
}
.book-item img {
    width: 100%;
    height: 220px;
    object-fit: cover;
    border-radius: 6px;
}
.book-item h4 {
    margin-top: 8px;
    font-size: 15px;
    color: #333;
}
.price {
    color: #d32f2f;
    font-weight: bold;
    margin-top: 5px;
}
.nav-buttons {
    position: absolute;
    top: 40%;
    width: 100%;
    display: flex;
    justify-content: space-between;
}
.nav-buttons button {
    background-color: #1976d2;
    border: none;
    color: white;
    font-size: 20px;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    cursor: pointer;
    transition: all 0.3s;
}
.nav-buttons button:hover {
    background-color: #0d47a1;
}
</style>

<asp:UpdatePanel ID="UpdatePanelSachMoi" runat="server">
    <ContentTemplate>
        <div class="sachmoi-container">
            <div class="nav-buttons">
                <asp:Button ID="btnPrev" runat="server" Text="❮" OnClick="btnPrev_Click" />
                <asp:Button ID="btnNext" runat="server" Text="❯" OnClick="btnNext_Click" />
            </div>

            <div class="book-list">
                <asp:Repeater ID="rptSachMoi" runat="server" OnItemCommand="rptSachMoi_ItemCommand">
                    <ItemTemplate>
                        <div class="book-item">
                            <asp:LinkButton ID="lnkChiTiet" runat="server" CommandName="ChiTiet"
                                CommandArgument='<%# Eval("MaSach") %>'>
                                <asp:Image ID="imgHinhAnh" runat="server"
                                    ImageUrl='<%# ResolveUrl("~/" + Eval("HinhAnh")) %>' />
                                <h4><%# Eval("TenSach") %></h4>
                                <div class="price"><%# string.Format("{0:N0} đ", Eval("GiaBan")) %></div>
                                <div>Số lượng: <%# Eval("SoLuongTon") %></div>
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
