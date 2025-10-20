<%@ Page Title="" Language="C#" MasterPageFile="~/pages/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DAHP2_WebSiteBanSach.pages.Default" %>
<%@ Register Src="~/pages/SachMoi.ascx" TagPrefix="uc" TagName="SachMoi" %>
<%@ Register Src="~/pages/SachTheoChuDe.ascx" TagPrefix="uc" TagName="SachTheoChuDe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <uc:SachMoi runat="server" ID="SachMoiControl" />
    <uc:SachTheoChuDe runat="server" ID="SachTheoChuDe" />
</asp:Content>

