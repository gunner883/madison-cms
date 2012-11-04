<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../../../masterpages/umbracoPage.Master" CodeBehind="EditStandardValueKeys.aspx.cs" Inherits="Sitereactor.StandardValues.EditStandardValueKeys" %>
<%@ Register Namespace="umbraco" TagPrefix="umb" Assembly="umbraco" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
  <script type="text/javascript">

    var preExecute;

    function doSubmit() { document.forms[0].submit(); }

    var functionsFrame = this;
    var tabFrame = this;
    var isDialog = true;
    var submitOnEnter = true;
  </script>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="body">
    <div style="padding-top: 20px">
        <div style="width:80px;float:left;">Key:</div> <asp:TextBox ID="tbName" CssClass="guiInputText guiInputStandardSize" runat="server">$key$</asp:TextBox>
        <br/><br/>
        <div style="width:80px;float:left;">Key Type:</div> <asp:DropDownList ID="ddlTypes" CssClass="guiInputText guiInputStandardSize umbIconDropdownList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTypes_OnSelectedIndexChanged">
            <asp:ListItem Value="-1">Select a Type</asp:ListItem>
            <asp:ListItem Value="date">Date</asp:ListItem>
            <asp:ListItem Value="dictionary">Dictionary Item</asp:ListItem>
            <asp:ListItem Value="item">Node</asp:ListItem>
            <asp:ListItem Value="static">Static Value</asp:ListItem>
            <asp:ListItem Value="xpath">XPath</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div style="padding-top: 20px">
        <div style="width:80px;float:left;"><asp:Literal ID="ltrValueLabel" runat="server" Text="Value: " /></div> <asp:TextBox ID="tbValue" CssClass="guiInputText guiInputStandardSize" runat="server"></asp:TextBox><br/>
        <br/><br/>
        <div style="width:80px;float:left;"><asp:Literal ID="ltrLabel" runat="server" /></div><asp:TextBox ID="tbCultureOrItemId" Visible="false" CssClass="guiInputText guiInputStandardSize" runat="server"></asp:TextBox><br/>
    </div>
    <div style="padding-top: 20px; margin-bottom:5px; clear:both">
        <asp:Button ID="btnCreateKey" runat="server" OnClick="btnCreateKey_OnClick" style="Width:90px" />
        &nbsp; <em><%= umbraco.ui.Text("or") %></em> &nbsp;
        <a href="#" style="color: blue" onclick="top.closeModal()"><%=umbraco.ui.Text("cancel")%></a>
    </div>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="footer">
  <script type="text/javascript">
    function setFocusOnText() {
      for (var i = 0; i < document.forms[0].length; i++) {
        if (document.forms[0][i].type == 'text') {
          document.forms[0][i].focus();
          break;
        }
      }
  }
    
    <%if (!IsPostBack) { %>
    setTimeout("setFocusOnText()", 100);
    <%} %>
  </script>
</asp:Content>