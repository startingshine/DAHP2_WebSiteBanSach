<%@ Page Title="Chi Tiết Sách" Language="C#" MasterPageFile="~/pages/site.Master" AutoEventWireup="true" CodeBehind="ChiTietSach.aspx.cs" Inherits="DAHP2_WebSiteBanSach.pages.ChiTietSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .book-detail {
            display: flex;
            gap: 30px;
            margin: 40px auto;
            width: 80%;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .book-image img {
            width: 300px;
            border-radius: 10px;
        }
        .book-info {
            flex: 1;
        }
        .book-info h2 {
            color: #333;
        }
        .price {
            font-size: 20px;
            color: #e60000;
            margin: 15px 0;
        }
        .btn-add {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }
        .btn-add:hover {
            background: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="book-detail">
        <div class="book-image">
            <asp:Image ID="imgSach" runat="server" Width="300px" />
        </div>
        <div class="book-info">
            <h2><asp:Label ID="lblTenSach" runat="server" /></h2>
            <p><strong>Tác giả:</strong> <asp:Label ID="lblTacGia" runat="server" /></p>
            <p><strong>Nhà xuất bản:</strong> <asp:Label ID="lblNXB" runat="server" /></p>
            <p class="price">Giá: <asp:Label ID="lblGia" runat="server" /> VNĐ</p>
            <p><asp:Label ID="lblMoTa" runat="server" /></p>
            <br />
            <asp:Button ID="btnThemGio" runat="server" Text="Thêm vào giỏ hàng" CssClass="btn-add" OnClick="btnThemGio_Click" />
        </div>
    </div>
</asp:Content>
