<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:didl="urn:mpeg:mpeg21:2002:02-DIDL-NS" xmlns:ddd="http://www.kb.nl/namespaces/ddd" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns="" xmlns:dcx="http://krait.kb.nl/coop/tel/handbook/telterms.html" xmlns:didmodel="urn:mpeg:mpeg21:2002:02-DIDMODEL-NS" xmlns:srw_dc="info:srw/schema/1/dc-v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" xmlns:oai="http://www.openarchives.org/OAI/2.0/">

<xsl:output method="xml" omit-xml-declaration="yes" standalone="yes" indent="no"/>

<xsl:template match="/">
    <xsl:text disable-output-escaping="yes"> &lt;add&gt;</xsl:text>
    <xsl:text disable-output-escaping="yes"> &lt;doc&gt;</xsl:text>
        <xsl:apply-templates select="//srw_dc:dc"/>
    <xsl:text disable-output-escaping="yes"> &lt;/doc&gt;</xsl:text>
    <xsl:text disable-output-escaping="yes"> &lt;/add&gt;</xsl:text>
</xsl:template>

<xsl:template match="//srw_dc:dc/*">
    <xsl:text disable-output-escaping="yes">&lt;field name="</xsl:text>
       <xsl:value-of select="name()" />
    <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text disable-output-escaping="yes">&lt;/field&gt;</xsl:text>
</xsl:template>

</xsl:stylesheet>

