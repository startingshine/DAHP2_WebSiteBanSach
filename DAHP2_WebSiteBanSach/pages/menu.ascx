<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu.ascx.cs" Inherits="DAHP2_WebSiteBanSach.pages.menu" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="../css/Style.css">
<style>
/* ----- Overlay mờ ----- */
#overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.4);
    z-index: 1000;
}

/* ----- Menu bên trái ----- */
#sideMenu {
    position: fixed;
    top: 0;
    left: -30%;
    width: 30%;
    height: 100%;
    background: #fff;
    box-shadow: 4px 0 8px rgba(0,0,0,0.2);
    transition: left 0.3s ease;
    z-index: 1001;
    overflow-y: auto;
    border-right: 1px solid #ddd;
}

#sideMenu.active {
    left: 0;
}

.menu-item {
    display: block;
    padding: 12px 16px;
    color: #333;
    text-decoration: none;
    border-bottom: 1px solid #eee;
    transition: background 0.2s;
}

.menu-item:hover {
    background: #f5f5f5;
    color: #007bff;
}
</style>
<header class="navbar">
        <div class="logo" style="margin-right:100px;">
            <img src="../anh/fahasa-logo.jpg" alt="Fahasa Logo">
        </div>
        <div> 
            <i id="menuToggle" class="fas fa-bars" 
                style="font-size: 26px; cursor: pointer; position: relative; z-index: 1001; margin: 10px;"></i>

<div id="overlay"></div>

<div id="sideMenu">
    <h3 style="text-align:center; padding:10px 0; border-bottom:1px solid #ccc;">Danh mục sách</h3>
    <asp:Repeater ID="rptChuDe" runat="server">
        <ItemTemplate>
            <a href='DanhMuc.aspx?MaChuDe=<%# Eval("MaChuDe") %>' class="menu-item">
                <%# Eval("TenChuDe") %>
            </a>
        </ItemTemplate>
    </asp:Repeater>
</div>
        </div>
        <div>
            <a href="QuanLyDuLieu.aspx">QUẢN LÝ DỮ LIỆU</a>
            </div>
        <div class="search-bar">
            <input type="text" placeholder="Nobel 2025 - Vũ Điệu Quỷ Satan" style="width:400px; height: 30px;"/>
            <button><i class="fa fa-search"></i></button>
        </div>

        <div class="nav-icons">
            <a href="#" class="icon-item"><i class="fa fa-shopping-cart"></i><span>Giỏ Hàng</span></a>
            <a href="#" class="icon-item"><i class="fa fa-user"></i><span>Đăng nhập</span></a>
            
        </div>
    </header>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const menuIcon = document.getElementById("menuToggle");
        const sideMenu = document.getElementById("sideMenu");
        const overlay = document.getElementById("overlay");

        function toggleMenu() {
            const isOpen = sideMenu.classList.contains("active");
            if (isOpen) {
                sideMenu.classList.remove("active");
                overlay.style.display = "none";
            } else {
                sideMenu.classList.add("active");
                overlay.style.display = "block";
            }
        }

        menuIcon.addEventListener("click", toggleMenu);
        overlay.addEventListener("click", toggleMenu);
    });
</script>
<script src="../js/Scripts.js"></script>