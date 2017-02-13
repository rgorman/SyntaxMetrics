<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
        
    </xsl:template>
    <xsl:template match="word">
        <xsl:choose>
            <xsl:when test="./@postag">
                <xsl:copy-of select="."/>
                
                
            </xsl:when>
            <xsl:otherwise>
                <word>
                    <xsl:copy-of select="@*"/>
                    <xsl:attribute name="postag">e--------</xsl:attribute>
                </word>
            </xsl:otherwise>
        </xsl:choose>
        
        
    </xsl:template>

    
    
</xsl:stylesheet>