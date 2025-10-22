<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dangnhap.aspx.cs" Inherits="DAHP2_WebSiteBanSach.pages.Dangnhap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        html, body {
    height: 100%;
    margin: 0;
    padding: 0;
}
    body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-image: url('../anh/backgrdk.jpg'); /* thay ảnh theo ý thiếu gia */
    background-size: cover;      /* ảnh phủ toàn màn hình */
    background-position: center; /* căn giữa ảnh */
    background-repeat: no-repeat;
    margin: 0;
    padding: 0;
        }

    .login-form {
        max-width: 400px;
        margin: 50px auto;
        padding: 30px;
        border-radius: 12px;
        background-image: url('../anh/anhkhung.jpg');
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .login-form h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        color: #555;
        margin-bottom: 5px;
        font-weight: 600;
    }

    .form-group input[type="text"],
    .form-group input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
    }

    .form-group input:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 4px rgba(0, 123, 255, 0.3);
    }

    .login-button {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
    }

    .login-button:hover {
        background-color: #0056b3;
    }

    .link-register {
        display: block;
        text-align: center;
        margin-top: 15px;
        color: #007bff;
        text-decoration: none;
    }

    .link-register:hover {
        text-decoration: underline;
    }

    .error-label {
        color: red;
        text-align: center;
        margin-top: 10px;
        font-weight: bold;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-form">
    <h2>Đăng nhập</h2>

    <div class="form-group">
        <label for="txtTaiKhoan">Tên tài khoản:</label>
        <asp:TextBox ID="txtTaiKhoan" runat="server" CssClass="form-control" Placeholder="Nhập tài khoản" />
    </div>

    <div class="form-group">
        <label for="txtMatKhau">Mật khẩu:</label>
        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" Placeholder="Nhập mật khẩu" TextMode="Password" />
    </div>

    <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" CssClass="login-button" OnClick="btnDangNhap_Click" />

    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="link-register" PostBackUrl="~/pages/Dangky.aspx">Bạn chưa có tài khoản? Đăng ký</asp:LinkButton>

    <asp:Label ID="lblThongBao" runat="server" CssClass="error-label"></asp:Label>
</div>
    </form>
</body>
</html>
