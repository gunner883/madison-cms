<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:u="urn:umlaut:xslt"
	xmlns:umbraco.library="urn:umbraco.library"
	exclude-result-prefixes="msxml umbraco.library">


<xsl:output method="xml" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>

<xsl:variable name="displayFields" select="u:getListParameter(string(//macro/displayFields), 'bodyText')"/>

<xsl:template match="/">
	<a id="homeButton" class="button" href="#{$currentPage/ancestor-or-self::node [@level = 1]/@id}">Home</a>

	<xsl:call-template name="iphonepage">
    		<xsl:with-param name="node" select="$currentPage/ancestor-or-self::node [@level = 1]"/>
		<xsl:with-param name="selected" select="'true'"/>
  	</xsl:call-template>

</xsl:template>

<xsl:template name="iphonepage">
	<xsl:param name="node" />
	<xsl:param name="selected" />
	<xsl:choose>
		<xsl:when test="count($node/node [string(data [@alias='umbracoNaviHide']) != '1']) = 0">
			<xsl:variable name="displayField">
				<xsl:call-template name="displayFieldText">
					<xsl:with-param name="item" select="."/>
					<xsl:with-param name="fieldList" select="$displayFields"/>
				</xsl:call-template>
			</xsl:variable>
			<div id="{$node/@id}" class="panel" title="{$node/@nodeName}">
        			<h2><xsl:value-of select="$node/@nodeName"/></h2>
				<xsl:value-of select="$displayField" disable-output-escaping="yes"/>
   		 	</div>
		</xsl:when>
		<xsl:otherwise>
			<ul id="{$node/@id}" title="{$node/@nodeName}">
				<xsl:if test="$selected = 'true'">
					<xsl:attribute name="selected">
						<xsl:text>true</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:for-each select="$node/node [string(data [@alias='umbracoNaviHide']) != '1']">
					<li><a href="#{@id}"><xsl:value-of select="@nodeName"/></a></li>
				</xsl:for-each>
			</ul>
			<xsl:for-each select="$node/node [string(data [@alias='umbracoNaviHide']) != '1']">
 		 		<xsl:call-template name="iphonepage">
    					<xsl:with-param name="node" select="."/>
  				</xsl:call-template>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="displayFieldText">
	<xsl:param name="item"/>
	<xsl:param name="fieldList"/>

	<xsl:variable name="fieldName">
		<xsl:value-of select="u:getFirstElement($fieldList, ',')"/>
	</xsl:variable>
	<xsl:variable name="remainingFields">
		<xsl:value-of select="u:removeFirstElement($fieldList, ',')"/>
	</xsl:variable>

	<xsl:choose>
	
		<xsl:when test="count($item/data[@alias=$fieldName]) = 1 and string($item/data[@alias=$fieldName]) != ''">
			<xsl:value-of select="string($item/data[@alias=$fieldName])"/>
		</xsl:when>

		<xsl:when test="$remainingFields != ''">

		<xsl:call-template name="displayFieldText">
			<xsl:with-param name="item" select="$item"/>
			<xsl:with-param name="fieldList" select="$remainingFields"/>
		</xsl:call-template>
		</xsl:when>

	</xsl:choose>
</xsl:template>

<msxsl:script language="C#" implements-prefix="u">
	<![CDATA[
	public string getFirstElement(string delimitedList, string delimiter)
	{

		while (delimitedList.IndexOf(delimiter) == 0)
			delimitedList = delimitedList.Remove(0, delimiter.Length).Trim();

		if (delimitedList.Length == 0)
			return "";


		if (delimiter == " " && delimitedList.Substring(0, 1) == "'" && delimitedList.IndexOf("'", 1) > -1)
			return delimitedList.Substring(1, delimitedList.IndexOf("'", 1) - 1);

		if (delimiter == " " && delimitedList.Substring(0, 1) == "\"" && delimitedList.IndexOf("\"", 1) > -1)
			return delimitedList.Substring(1, delimitedList.IndexOf("\"", 1) - 1);


		if (delimitedList.IndexOf(delimiter) == -1)
			return delimitedList.Trim();


		return delimitedList.Split(delimiter.ToCharArray()[0])[0].Trim();
	}

	public string removeFirstElement(string delimitedList, string delimiter)
	{
		string firstElement = getFirstElement(delimitedList, delimiter);


		if (delimiter == " " && delimitedList.Substring(0, 1) == "'" && delimitedList.IndexOf("'", 1) > -1)
			return delimitedList.Remove(0, firstElement.Length + 2).Trim();

		if (delimiter == " " && delimitedList.Substring(0, 1) == "\"" && delimitedList.IndexOf("\"", 1) > -1)
			return delimitedList.Remove(0, firstElement.Length + 2).Trim();

		while (delimitedList.IndexOf(delimiter) == 0)
			delimitedList = delimitedList.Remove(0, delimiter.Length).Trim();

		return delimitedList.Remove(0, firstElement.Length).Trim();
	}

	public string getListParameter(string value, string defaultValue)
	{
		// remove all spaces
		value = value.Replace(" ", "");
		defaultValue = defaultValue.Replace(" ", "");

		if (value == "")
		return "," + defaultValue + ",";
		else
		return "," + value + ",";
	}

]]>
</msxsl:script>

</xsl:stylesheet>