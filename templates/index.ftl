<#include "header.ftl">

<#include "menu.ftl">

<div class="page-header">
    <h1>Blog</h1>
</div>
<#list posts as post>
    <#if (post.status == "published")>
    <a href="${post.uri}"><h1><#escape x as x?xml>${post.title}</#escape></h1></a>
    <p>${post.date?string("dd MMMM yyyy")}</p>          <p>${post.body}</p>
    </#if>
</#list>

<hr/>

<#include "footer.ftl">