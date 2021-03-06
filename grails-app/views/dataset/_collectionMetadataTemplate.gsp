<%@ page import="species.Species"%>
<%@ page import="species.License"%>
<%@ page import="species.dataset.Dataset1"%>
<%@ page import="species.dataset.DataTable"%>
<%@ page import="species.dataset.DataPackage.SupportingModules"%>
<%@ page import="species.groups.CustomField"%>
<%@ page import="species.auth.SUser"%>
<% 

Map<SupportingModules, CustomField> supportingModules;
if(supportingModules_dp) {
    supportingModules = supportingModules_dp;
    } else if(instance  && instance instanceof DataTable) {
        supportingModules = instance.dataset.dataPackage.supportingModules();
    } else if(instance && instance instanceof Dataset1 && instance.dataPackage == null) {
        supportingModules = supportingModules?:[:];
    }else if(instance && instance instanceof Dataset1){
        supportingModules = instance.dataPackage?.supportingModules()
    } 
%>

<div class="section">
    <g:if test="${supportingModules.containsKey(SupportingModules.TITLE)}">
    <h3><g:message code="default.title.label" /> </h3>
    <div class="control-group ${hasErrors(bean: instance, field: 'title', 'error')}">
        <label for="name" class="control-label"><g:message
            code="default.title.label" default="${g.message(code:'default.title.label')}" />*</label>
        <div class="controls textbox">
            <div class="" style="z-index: 3;">
                <g:textField name="title"  class="input-block-level" value="${instance?.title}" placeholder="${g.message(code:'default.title.label')}"/>
                <div class="help-inline">
                    <g:hasErrors bean="${instance}" field="title">
                    <g:eachError bean="${instance}" field="title">
                    <li><g:message error="${it}" /></li>
                    </g:eachError>
                    </g:hasErrors>
                </div>
            </div>
        </div>
    </div>
    </g:if>

    <g:if test="${supportingModules.containsKey(SupportingModules.SUMMARY)}">
    <div class="control-group ${hasErrors(bean: instance, field: 'summary', 'error')}">
        <label for="summary" class="control-label"><g:message code="default.summary.label" />*</label>
        <div class="controls  textbox">

            <textarea id="summary" name="summary" placeholder="${g.message(code:'dataset.small.description')}">${instance?.summary}</textarea>
            <div class="help-inline">
                <g:hasErrors bean="${instance}" field="summary">
                    <g:eachError bean="${instance}" field="summary">
                        <li><g:message error="${it}" /></li>
                    </g:eachError>
                </g:hasErrors>
            </div>
        </div>
    </div>
    </g:if>

    <g:if test="${supportingModules.containsKey(SupportingModules.DESCRIPTION)}">
    <div class="control-group ${hasErrors(bean: instance, field: 'description', 'error')}">
        <label for="description" class="control-label"><g:message code="default.description.label" /></label>
        <div class="controls  textbox">

            <textarea id="description" name="description" placeholder="${g.message(code:'dataset.small.description')}">${instance?.description}</textarea>
            <div class="help-inline">
                <g:hasErrors bean="${instance}" field="description">
                    <g:eachError bean="${instance}" field="description">
                        <li><g:message error="${it}" /></li>
                    </g:eachError>
                </g:hasErrors>
            </div>
        </div>
    </div>
    </g:if>
</div>

    <g:if test="${supportingModules.containsKey(SupportingModules.USAGE_RIGHTS)}">
<div class="section">
    <h3><g:message code="default.usageRights.label" /> </h3>
    
    <div class="control-group ${hasErrors(bean: instance.access, field: 'licenseId', 'error')}">
        <label class="control-label" for="License"><g:message code="default.licenses.label" /> </label>

        <div class="controls">

            <div id="licenseDiv" class="licence_div dropdown">

                <a id="selected_license" class="btn dropdown-toggle btn-mini"
                    data-toggle="dropdown"> 
                    <% License selectedLicense = (instance.access && instance.access.licenseId)? License.read(instance.access.licenseId):null%> 
                    <img
                    src="${selectedLicense ? assetPath(src:'/all/license/'+selectedLicense.name.getIconFilename()+'.png', absolute:true):assetPath(src:'/all/license/'+'cc_by.png', absolute:true)}"
                    title="${g.message(code:'title.set.license')}" /> <b class="caret"></b>
                </a>

                <ul id="license_options" class="dropdown-menu license_options">
                    <span><g:message code="default.choose.license.label" /></span>
                    <g:each in="${species.License.list()}" var="l">
                    <li class="license_option"
                    onclick="$('#license').val($.trim($(this).text()));$('#selected_license').find('img:first').replaceWith($(this).html());">
                    <img
                    src="${assetPath(src:'/all/license/'+l?.name?.getIconFilename()+'.png', absolute:true)}" /><span
                        style="display: none;"> ${l?.name?.value}
                    </span>
                    </li>
                    </g:each>
                </ul>

                <input id="license" type="hidden" name="licenseName"
                value="${selectedLicense?.name?.value()}"></input>

            </div>
        </div>
    </div>
    <!-- customFields -->
    <g:if test="${supportingModules}">
    <div class="customFieldForm" style="position: relative; overflow: visible;">
        <g:each var="customFieldInstance" in="${supportingModules[SupportingModules.USAGE_RIGHTS]}">
            <g:render template="/dataTable/customFieldTemplate" model="['instance':instance, 'customFieldInstance':customFieldInstance]"/>
        </g:each>
    </div>
    </g:if>
</div>
</g:if>

    <g:if test="${supportingModules.containsKey(SupportingModules.PARTY)}">
<div class="section">
    <h3><g:message code="default.party.label" /> </h3>

    <div  class="control-group ${hasErrors(bean: instance.party, field: 'contributorId', 'error')}">
        <label for="contributor" class="control-label"><g:message
            code="default.party.contributor"  />*</label>
        <div class="controls  textbox">
            <sUser:selectUsers model="['id':autofillUserComp]" />
            <%def user = SUser.read(instance?.party?.contributorId);%>
            <input type="hidden" name="contributorUserIds" id="contributorUserIds" data-contributorid="${user?.id}"  data-contributorname="${user?.name}" />
            <div class="help-inline">
            <g:hasErrors bean="${instance.party}" field="contributorId">
            <g:eachError bean="${instance.party}" field="contributorId">
            <li><g:message error="${it}" /></li>
            </g:eachError>
            </g:hasErrors>
            </div>

        </div>
    </div>


    <div class="control-group ${hasErrors(bean: instance, field: 'attributions', 'error')}">
        <label for="attributions" class="control-label"><g:message
            code="default.attribution.label" default="${g.message(code:'default.attribution.label')}" /></label>
        <div class="controls textbox">
            <div class="" style="z-index: 3;">
                <textarea class="input-block-level" name="attributions" placeholder="${g.message(code:'checklist.details.enter.attribution')}">${instance?.party?.attributions}</textarea>
                <div class="help-inline">
                    <g:hasErrors bean="${instance.party}" field="attributions">
                    <g:eachError bean="${instance.party}" field="attributions">
                    <li><g:message error="${it}" /></li>
                    </g:eachError>
                    </g:hasErrors>
                </div>
            </div>
        </div>
    </div>
    <!-- customFields -->
    <div class="customFieldForm" style="position: relative; overflow: visible;">
    <g:if test="${supportingModules}">
        <g:each var="customFieldInstance" in="${supportingModules[SupportingModules.PARTY]}">
            <g:render template="/dataTable/customFieldTemplate" model="['instance':instance, 'customFieldInstance':customFieldInstance]"/>
        </g:each>
    </g:if>
    </div>
</div>
</g:if>

<g:if test="${supportingModules.containsKey(SupportingModules.TAXONOMIC_COVERAGE)}">
<div class="section">
    <h3><g:message code="default.taxonomicCoverage.label" /> </h3>
    <g:render template="/observation/taxonInput" model="['instance':instance.taxonomicCoverage]"/>
</div>
</g:if>

<g:if test="${supportingModules.containsKey(SupportingModules.TEMPORAL_COVERAGE)}">
<div class="section">
    <h3><g:message code="default.temporalCoverage.label" /> </h3>
    <g:render template="/observation/dateInput" model="['observationInstance':instance.temporalCoverage]"/>
</div>
</g:if>

<g:if test="${supportingModules.containsKey(SupportingModules.GEOGRAPHICAL_COVERAGE)}">
<div class="section">
    <h3><g:message code="default.geographicalCoverage.label" /> </h3>
    <% def obvInfoFeeder = lastCreatedObv ? lastCreatedObv : instance.geographicalCoverage; %>
    <div>
        <obv:showMapInput model="[sourceInstance:instance.geographicalCoverage, obvInfoFeeder:obvInfoFeeder, locationHeading:'Where did you find this observation?', webaddress:params.webaddress]"></obv:showMapInput>
    </div>

</div>
</g:if>

<g:if test="${supportingModules.containsKey(SupportingModules.METHODS) || supportingModules.containsKey(SupportingModules.PROJECT) || supportingModules.containsKey(SupportingModules.OTHERS) }">
<div class="section">
    <h3><g:message code="default.others.label" /> </h3>

    <g:if test="${supportingModules.containsKey(SupportingModules.PROJECT)}">
     <div class="control-group ${hasErrors(bean: instance, field: 'project', 'error')}">
        <label for="project" class="control-label"><g:message
            code="default.project.label" default="${g.message(code:'default.project.label')}" /></label>
        <div class="controls textbox">
            <div class="" style="z-index: 3;">
                <g:textField name="project" value="${instance?.project}" placeholder="${g.message(code:'default.project.label')}"/>
                <div class="help-inline">
                    <g:hasErrors bean="${instance}" field="project">
                    <g:eachError bean="${instance}" field="project">
                    <li><g:message error="${it}" /></li>
                    </g:eachError>
                    </g:hasErrors>
                </div>
            </div>
        </div>
    </div>
    </g:if>


    <g:if test="${supportingModules.containsKey(SupportingModules.METHODS)}">
    <div class="control-group ${hasErrors(bean: instance, field: 'methods', 'error')}">
        <label for="name" class="control-label"><g:message
            code="default.methods.label" default="${g.message(code:'default.methods.label')}" /></label>
        <div class="controls textbox">
            <div class="" style="z-index: 3;">
                <g:textField name="methods" value="${instance?.methods}" placeholder="${g.message(code:'default.methods.label')}"/>
                <div class="help-inline">
                    <g:hasErrors bean="${instance}" field="methods">
                    <g:eachError bean="${instance}" field="methods">
                    <li><g:message error="${it}" /></li>
                    </g:eachError>
                    </g:hasErrors>
                </div>
            </div>
        </div>
    </div>
    </g:if>

    <!-- customFields -->
    <g:if test="${supportingModules}">
    <div class="customFieldForm" style="position: relative; overflow: visible;">
        <g:each var="customFieldInstance" in="${supportingModules[SupportingModules.OTHERS]}">
            <g:render template="/dataTable/customFieldTemplate" model="['instance':instance, 'customFieldInstance':customFieldInstance]"/>
        </g:each>
    </div>
    </g:if>

    <!--div class="control-group ${hasErrors(bean: instance, field: 'externalUrl', 'error')}">
        <label for="source" class="control-label"><g:message
            code="default.externalId.label" default="${g.message(code:'default.externalId.label')}" /></label>
        <div class="controls textbox">
            <div class="" style="z-index: 3;">
                <g:textField name="externalUrl" value="${instance?.externalUrl}" placeholder="Add external url for the dataPackage" />
                <div class="help-inline">
                    <g:hasErrors bean="${instance}" field="externalUrl">
                    <g:eachError bean="${instance}" field="externalUrl">
                    <li><g:message error="${it}" /></li>
                    </g:eachError>
                    </g:hasErrors>
                </div>
            </div>
        </div>
    </div-->
</div>
</g:if>
