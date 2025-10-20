<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dangky.aspx.cs" Inherits="DAHP2_WebSiteBanSach.pages.Dangky" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng ký</title>
    <style type="text/css">
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .register-container {
            max-width: 500px;
            margin: 60px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .register-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="email"] {
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

        .register-button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .register-button:hover {
            background-color: #218838;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <h2>Đăng ký tài khoản</h2>

            <div class="form-group">
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" Placeholder="Họ tên" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email" TextMode="Email" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" Placeholder="Số điện thoại" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" Placeholder="Địa chỉ" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtTK" runat="server" CssClass="form-control" Placeholder="Tên đăng nhập" />
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtMK" runat="server" CssClass="form-control" Placeholder="Mật khẩu" TextMode="Password" />
            </div>

            <asp:Button ID="btnDangKy" runat="server" CssClass="register-button" Text="Đăng ký" OnClick="btnDangKy_Click" />

            <asp:Label ID="lblThongBao" runat="server" CssClass="error-message" />
        </div>
    </form>
</body>
</html>
>
