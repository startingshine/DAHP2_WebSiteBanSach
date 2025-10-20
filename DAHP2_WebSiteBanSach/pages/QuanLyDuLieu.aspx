<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyDuLieu.aspx.cs" Inherits="DAHP2_WebSiteBanSach.pages.QuanLyDuLieu" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Quản Lý Dữ Liệu Sách</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fafafa;
        }
        .form-container {
            margin: 20px;
            padding: 20px;
            border: 2px solid #ddd;
            border-radius: 10px;
            background: #f9f9f9;
            width: 600px;
        }
        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .form-row label {
            width: 140px;
            font-weight: bold;
        }
        .form-row input,
        .form-row select,
        .form-row textarea {
            flex: 1;
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .button-group {
            margin-top: 15px;
            text-align: center;
        }
        .button-group asp\:button {
            margin: 5px;
        }
        .button-disabled {
    opacity: 0.4;
    pointer-events: none; 
    transition: opacity 0.3s ease;
}

.button-enabled {
    opacity: 1;
    pointer-events: auto;
    transition: opacity 0.3s ease;
}

        .grid-container {
            margin: 20px;
        }
        img.book-img {
            width: 80px;
            height: 100px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- 🔹 Form nhập liệu -->
        <div class="form-container">
            <h2>Quản lý Sách</h2>
            <asp:HiddenField ID="hfMaSach" runat="server" />

            <div class="form-row">
                <label>Tên Sách:</label>
                <asp:TextBox ID="txtTenSach" runat="server" Width="300px" />
            </div>

            <div class="form-row">
                <label>Giá Bán:</label>
                <asp:TextBox ID="txtGiaBan" runat="server" />
            </div>

            <div class="form-row">
                <label>Số Lượng:</label>
                <asp:TextBox ID="txtSoLuong" runat="server" />
            </div>

            <div class="form-row">
                <label>Mô Tả:</label>
                <asp:TextBox ID="txtMoTa" TextMode="MultiLine" Rows="3" runat="server" />
            </div>

            <div class="form-row">
                <label>Chủ Đề:</label>
                <asp:DropDownList ID="ddlChuDe" runat="server" />
            </div>

            <div class="form-row">
                <label>Tác Giả:</label>
                <asp:DropDownList ID="ddlTacGia" runat="server" />
            </div>

            <div class="form-row">
                <label>Nhà Xuất Bản:</label>
                <asp:DropDownList ID="ddlNXB" runat="server" />
            </div>

            <div class="form-row">
                <label>Năm Xuất Bản:</label>
                <asp:TextBox ID="txtNamXB" runat="server" />
            </div>

            <div class="form-row">
                <label>Ảnh Sách:</label>
                <asp:FileUpload ID="fuHinhAnh" runat="server" />
            </div>

            <div class="form-row" style="justify-content:center;">
                <asp:Image ID="imgPreview" runat="server" Width="160" Height="180" Visible="false" />
            </div>

            <div class="button-group">
                <asp:Button ID="btnThem" runat="server" Text="Thêm" OnClick="btnThem_Click" />
                <asp:Button ID="btnSua" runat="server" Text="Cập Nhật" CssClass="button-disabled" OnClick="btnSua_Click" />
                <asp:Button ID="btnXoa" runat="server" Text="Xóa" CssClass="button-disabled" OnClick="btnXoa_Click" />
                <asp:Button ID="btnLamMoi" runat="server" Text="Làm Mới" OnClick="btnLamMoi_Click" />
            </div>

        </div>

        <!-- 🔹 Bảng hiển thị dữ liệu -->
        <div class="grid-container">
            <asp:GridView ID="gvSach" runat="server" AutoGenerateColumns="False"
                DataKeyNames="MaSach"
                OnSelectedIndexChanged="gvSach_SelectedIndexChanged" Width="1029px">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" SelectText="Chọn" />
                    <asp:BoundField DataField="MaSach" HeaderText="Mã Sách" ReadOnly="True" />
                    <asp:BoundField DataField="TenSach" HeaderText="Tên Sách" />
                    <asp:BoundField DataField="GiaBan" HeaderText="Giá" DataFormatString="{0:N0} đ" />
                    <asp:BoundField DataField="SoLuongTon" HeaderText="Tồn Kho" />
                    <asp:BoundField DataField="NamXuatBan" HeaderText="Năm XB" />
                    <asp:TemplateField HeaderText="Ảnh">
                        <ItemTemplate>
                            <asp:Image ID="imgHinhAnh" runat="server"
                                ImageUrl='<%# ResolveUrl("~/" + Eval("HinhAnh")) %>'
                                Width="100px" Height="100px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
