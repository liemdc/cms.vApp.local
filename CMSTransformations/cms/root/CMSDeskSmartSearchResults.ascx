<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div style="margin-bottom: 30px;">
  <%-- Search result image --%>
        <div style="border: solid 1px #eeeeee; width: 90px; height:90px; margin-right: 5px;" class="LeftAlign">
           <img src="<%# GetSearchImageUrl(UIHelper.GetImageUrl(Page, "CMSModules/CMS_SmartSearch/no_image.gif"),90) %>" alt="" />
        </div>
        <div class="LeftAlign">
            <%-- Search result title --%>
            <div style="text-align: left;">
                <a style="font-weight: bold" href='<%# "javascript:SelectItem(" + CMS.ExtendedControls.ControlsHelper.RemoveDynamicControls(ValidationHelper.GetString(GetSearchValue("nodeId"), "")) + ", '"+ ValidationHelper.GetString(GetSearchValue("DocumentCulture"), "") + "')" %>'>
                    <%#SearchHighlight(CMS.GlobalHelper.HTMLHelper.HTMLEncode(DataHelper.GetNotEmpty(Eval("Title"), "/")), "<span style='font-weight:bold;'>", "</span>")%> (<%#ValidationHelper.GetString(GetSearchValue("DocumentCulture"), "")%>)
                </a>
            </div>
            <%-- Search result content --%>
            <div style="margin-top: 5px; width: 590px;min-height:40px">
                <%#SearchHighlight(CMS.GlobalHelper.HTMLHelper.HTMLEncode(TextHelper.LimitLength(HttpUtility.HtmlDecode(CMS.GlobalHelper.HTMLHelper.StripTags(CMS.ExtendedControls.ControlsHelper.RemoveDynamicControls(GetSearchedContent(DataHelper.GetNotEmpty(Eval("Content"), ""))), false, " ")), 280, "...")), "<span style='background-color: #FEFF8F'>", "</span>")%><br />
            </div>
            <%-- Relevance, URL, Creattion --%>
            <div style="margin-top: 5px;">
                <%-- Relevance --%>
                <div title="Relevance: <%# Convert.ToInt32(ValidationHelper.GetDouble(Eval("Score"),0.0)*100) %>%"
                    style="width: 50px; border: solid 1px #aaaaaa; margin-top: 7px; margin-right: 6px;
                    float: left; color: #0000ff; font-size: 2pt; line-height: 4px; height: 4px;">
                    <div style="<%# "background-color:#a7d3a7;width:"+ Convert.ToString(Convert.ToInt32((ValidationHelper.GetDouble(Eval("Score"),0.0)/2)*100))  + "px;height:4px;line-height: 4px;"%>">
                    </div>
                </div>
                <%-- URL --%>
                <span style="color: #008000">
                    <%# TextHelper.BreakLine(SearchHighlight(SearchResultUrl(true),"<strong>","</strong>"),75,"<br />") %>
                </span>
                <%-- Creation --%>
                <span style="padding-left:5px;color: #888888; font-size: 9pt">
                    <%# GetDateTimeString(ValidationHelper.GetDateTime(Eval("Created"), DateTimeHelper.ZERO_TIME), true) %>
                </span>
            </div>
        </div>
        <div style="clear: both">
        </div>
    </div>