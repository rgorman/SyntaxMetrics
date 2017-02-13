<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <treebank>
            <xsl:copy-of select="@*"/>
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="sentence">
                <sentence>
                    <xsl:copy-of select="@*"></xsl:copy-of>
                    <xsl:for-each select="word">
                       <word>
                           <xsl:copy-of select="@*"/>
                           <xsl:attribute name="working_ref">
                               <xsl:value-of select="../@span"/> w-<xsl:value-of select="./@id"/>
                               
                           </xsl:attribute>
                       </word>
                    </xsl:for-each>
                    
                        
                          
                        
                        
                </sentence>
            </xsl:for-each>
        </treebank>
    </xsl:template>
    
</xsl:stylesheet>