<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="DonationDetails">
  <div class="Donation">
    <%# ResHelper.GetString(ValidationHelper.GetString(Eval("SKUName"), null)) %>
  </div>
  <div class="Customer">
    Donor: <%# Eval("CustomerFirstName") %> <%# Eval("CustomerLastName") %>, <%# Eval("CustomerCompany") %>
  </div>
  <div class="Amount">
    Amount: <%# CMS.Ecommerce.CurrencyInfoProvider.GetFormattedPrice(ValidationHelper.GetDouble(Eval("OrderItemTotalPriceInMainCurrency"), 0.0), CMSContext.CurrentSiteID) %>
  </div>
  <div class="Order">
    Date: <%# ValidationHelper.GetDateTime(Eval("OrderDate"), DateTimeHelper.ZERO_TIME).ToString("d") %><br>
  </div>
</div>
