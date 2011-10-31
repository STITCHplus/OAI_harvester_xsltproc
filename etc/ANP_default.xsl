<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:didl="urn:mpeg:mpeg21:2002:02-DIDL-NS" xmlns:ddd="http://www.kb.nl/namespaces/ddd" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns="" xmlns:dcx="http://krait.kb.nl/coop/tel/handbook/telterms.html" xmlns:didmodel="urn:mpeg:mpeg21:2002:02-DIDMODEL-NS" xmlns:srw_dc="info:srw/schema/1/dc-v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" xmlns:oai="http://www.openarchives.org/OAI/2.0/">

<xsl:output method="xml" omit-xml-declaration="yes" standalone="yes" indent="no"/>

<xsl:template match="/">
    <xsl:text disable-output-escaping="yes"> &lt;add&gt;</xsl:text>
        <xsl:apply-templates select="//didl:DIDL"/>
    <xsl:text disable-output-escaping="yes"> &lt;/add&gt;</xsl:text>
</xsl:template>

<xsl:template match="//didl:DIDL">
    <xsl:text disable-output-escaping="yes"> &lt;doc&gt;</xsl:text>
    <xsl:apply-templates select="didl:Item"/>
    <xsl:text disable-output-escaping="yes"> &lt;/doc&gt;</xsl:text>
</xsl:template>

<xsl:template match="didl:Item">
    <xsl:apply-templates select="didl:Component"/>
</xsl:template>

<xsl:template match="didl:Component">
    <xsl:apply-templates select="didl:Descriptor"/>
</xsl:template>


<xsl:template match="didl:Descriptor/didl:Statement">
    <xsl:choose>
        <xsl:when test="contains(.,'metadata')">
            <xsl:for-each select="../../didl:Resource/srw_dc:dcx/dc:*">
                <xsl:variable name="fieldname" select="substring-after(name(.), ':')"/>
                <xsl:choose>
                    <xsl:when test="contains($fieldname,'identifier')">
                        <xsl:text disable-output-escaping="yes">&lt;field name="</xsl:text>
                        <xsl:text>id</xsl:text>
                        <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text disable-output-escaping="yes">&lt;/field&gt;</xsl:text>
                    </xsl:when>
 
                    <xsl:otherwise>
                        <xsl:text disable-output-escaping="yes">&lt;field name="</xsl:text>
                        <xsl:value-of select="$fieldname"/>
                        <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text disable-output-escaping="yes">&lt;/field&gt;</xsl:text>
                    </xsl:otherwise>

                </xsl:choose>
            </xsl:for-each>
        </xsl:when>
        <xsl:when test="contains(.,'ocr')">
                <xsl:for-each select="../../*">
                    <xsl:if test="contains(@ref,'http://')">
                        <xsl:text disable-output-escaping="yes">&lt;field name="text"&gt;</xsl:text>
                        <xsl:value-of select="document(@ref)"/>
                        <xsl:text disable-output-escaping="yes">&lt;/field&gt;</xsl:text>
                    </xsl:if>
                </xsl:for-each>

            <!--
            <xsl:apply-templates select="../../didl:Component"/>
            <xsl:for-each select="../../didl:Component/didl:Resource/*">
                    here
                <xsl:value-of select="name()" />
            </xsl:for-each>
            -->
        </xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template select="didl:Component">
    <xsl:value-of select="."/>
</xsl:template>


<!--
    <xsl:apply-templates select="../didl:Resource"/>
<xsl:template match="didl:Resource/srw_dc:dcx/*">
    <xsl:for-each select=".">
    <xsl:choose>
        <xsl:when test="contains(name(), 'dc:')">
            
            <xsl:text disable-output-escaping="yes">&lt;field name="</xsl:text>
            <xsl:value-of select="substring-after(name(),':')"/>
            <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text disable-output-escaping="yes">&lt;/field&gt;</xsl:text>

            <xsl:choose>
                <xsl:when test="contains(name(.), 'date')">
                    <xsl:text disable-output-escaping="yes">&lt;field name="</xsl:text>
                    <xsl:value-of select="substring-after(name(),':')"/><xsl:text>_date</xsl:text> Might want to check the length of the date string here!
                    <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
                    <xsl:value-of select="."/><xsl:text>T00:00:00Z</xsl:text>
                    <xsl:text disable-output-escaping="yes">&lt;/field&gt;</xsl:text>
                </xsl:when>
            </xsl:choose>
-->
<!--
            <xsl:variable name="field_value" select="substring-after(name(.), ':')"/>
         </xsl:when>

    </xsl:choose>
    </xsl:for-each>
-->
</xsl:stylesheet>




<!--

  <xsl:template match="didl:Item">
    <xsl:element name="doc">
      <xsl:call-template name="krant">
        <xsl:with-param name="krantmeta" select="../../didl:Component/didl:Resource/srw_dc:dcx"/>
      </xsl:call-template>
      <xsl:call-template name="pagina">
        <xsl:with-param name="paginameta" select="../didl:Component/didl:Resource/srw_dc:dcx"/>
      </xsl:call-template>
      <xsl:call-template name="artikel">
        <xsl:with-param name="artikelmeta" select="didl:Component/didl:Resource/srw_dc:dcx"/>
      </xsl:call-template>
    </xsl:element>
  </xsl:template>

  <xsl:template name="krant">
    <xsl:param name="krantmeta"/>

    <xsl:element name="field">
      <xsl:attribute name="name">title</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:title"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">title_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:title"/>
    </xsl:element>

    <xsl:element name="field">
      <xsl:attribute name="name">date_date</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:date"/><xsl:text>T00:00:00Z</xsl:text>
    </xsl:element>

    <xsl:element name="field">
      <xsl:attribute name="name">date</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:date"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">date_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:date"/>
    </xsl:element>

    <xsl:element name="field">
      <xsl:attribute name="name">year</xsl:attribute>
      <xsl:value-of select="substring($krantmeta/dc:date,0,5)"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">year_str</xsl:attribute>
      <xsl:value-of select="substring($krantmeta/dc:date,0,5)"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">issue</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcx:issuenumber"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">issue_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcx:issuenumber"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">paperurl</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:identifier[not(@xsi:type)]"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">paperurl_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:identifier[not(@xsi:type)]"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">edition</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:temporal"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">edition_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:temporal"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">spatial</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:spatial"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">spatial_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:spatial"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">alternative</xsl:attribute>
      <xsl:value-of select="substring-after($krantmeta/dcterms:alternative[starts-with(.,'Ook')],'Ook bekend onder de naam ')"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">alternative_str</xsl:attribute>
      <xsl:value-of select="substring-after($krantmeta/dcterms:alternative[starts-with(.,'Ook')],'Ook bekend onder de naam ')"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">publisher</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:publisher"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">publisher_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:publisher"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">special_collection</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:isPartOf[position() = 3]"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">special_collection_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:isPartOf[position() = 3]"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">rights_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:rights"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">rights</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:rights"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">source</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:source"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">source_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:source"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">volume</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcx:volume"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">volume_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcx:volume"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">issued</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:issued"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">issued_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:issued"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">yearsDigitized</xsl:attribute>
      <xsl:value-of select="$krantmeta/ddd:yearsDigitized"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">yearsDigitized_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/ddd:yearsDigitized"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">spatialCreation</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:spatial[@xsi:type]"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">spatialCreation_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dcterms:spatial[@xsi:type]"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">forerunner</xsl:attribute>
      <xsl:value-of select="substring-after($krantmeta/dcterms:alternative[starts-with(.,'Eerder')],'Eerder verschenen onder de naam ')"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">forerunner_str</xsl:attribute>
      <xsl:value-of select="substring-after($krantmeta/dcterms:alternative[starts-with(.,'Eerder')],'Eerder verschenen onder de naam ')"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">ppn</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:identifier[@xsi:type]"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">ppn_str</xsl:attribute>
      <xsl:value-of select="$krantmeta/dc:identifier[@xsi:type]"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="pagina">
    <xsl:param name="paginameta"/>
    <xsl:element name="field">
      <xsl:attribute name="name">page</xsl:attribute>
      <xsl:value-of select="$paginameta/ddd:nativePageNumber"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">page_str</xsl:attribute>
      <xsl:value-of select="$paginameta/ddd:nativePageNumber"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">pageurl</xsl:attribute>
      <xsl:value-of select="$paginameta/dc:identifier"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">pageurl_str</xsl:attribute>
      <xsl:value-of select="$paginameta/dc:identifier"/>
    </xsl:element>
  </xsl:template>
  <xsl:template name="artikel">
    <xsl:param name="artikelmeta"/>
    <xsl:element name="field">
      <xsl:attribute name="name">id</xsl:attribute>
      <xsl:value-of select="normalize-space($artikelmeta/dc:identifier[not(@xsi:type)])"/><xsl:text>:ocr</xsl:text>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">id_str</xsl:attribute>
      <xsl:value-of select="normalize-space($artikelmeta/dc:identifier[not(@xsi:type)])"/><xsl:text>:ocr</xsl:text>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">ocr_title</xsl:attribute>
      <xsl:value-of select="$artikelmeta/dc:title"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">ocr_title_str</xsl:attribute>
      <xsl:value-of select="$artikelmeta/dc:title"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">type</xsl:attribute>
      <xsl:value-of select="$artikelmeta/dc:subject"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">type_str</xsl:attribute>
      <xsl:value-of select="$artikelmeta/dc:subject"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">url</xsl:attribute>
      <xsl:value-of select="normalize-space($artikelmeta/dc:identifier[not(@xsi:type)])"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">url_str</xsl:attribute>
      <xsl:value-of select="normalize-space($artikelmeta/dc:identifier[not(@xsi:type)])"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">ocr_identifier</xsl:attribute>
      <xsl:value-of select="normalize-space($artikelmeta/dc:identifier[not(@xsi:type)])"/>
      <xsl:text>:ocr</xsl:text>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">ocr_identifier_str</xsl:attribute>
      <xsl:value-of select="normalize-space($artikelmeta/dc:identifier[not(@xsi:type)])"/>
      <xsl:text>:ocr</xsl:text>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">text</xsl:attribute>
      <xsl:value-of select="document(concat(normalize-space($artikelmeta/dc:identifier[not(@xsi:type)]), ':ocr'))"/>
    </xsl:element>
    <xsl:element name="field">
      <xsl:attribute name="name">text_str</xsl:attribute>
      <xsl:value-of select="document(concat(normalize-space($artikelmeta/dc:identifier[not(@xsi:type)]), ':ocr'))"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
!-->
