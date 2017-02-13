<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="treebank">
        <projectivity_document>            
            <xsl:copy-of select="@*"/>
            
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            
            <xsl:for-each select="sentence">
                <sentence>
                    <xsl:copy-of select="@*"/><xsl:attribute name="status">blop</xsl:attribute>
                    
                    <xsl:for-each select="word">
                        
                        <xsl:variable name="head_1" select="./@head"/>
                        <xsl:variable name="head_2" select="parent::sentence/word[@id = $head_1]/@head"/>
                        <xsl:variable name="head_3" select="parent::sentence/word[@id = $head_2]/@head"/>
                        <xsl:variable name="head_4" select="parent::sentence/word[@id = $head_3]/@head"/>
                        <xsl:variable name="head_5" select="parent::sentence/word[@id = $head_4]/@head"/>
                        <xsl:variable name="head_6" select="parent::sentence/word[@id = $head_5]/@head"/>
                        <xsl:variable name="head_7" select="parent::sentence/word[@id = $head_6]/@head"/>
                        <xsl:variable name="head_8" select="parent::sentence/word[@id = $head_7]/@head"/>
                        <xsl:variable name="head_9" select="parent::sentence/word[@id = $head_8]/@head"/>
                        <xsl:variable name="head_10" select="parent::sentence/word[@id = $head_9]/@head"/>
                        <xsl:variable name="head_11" select="parent::sentence/word[@id = $head_10]/@head"/>
                        <xsl:variable name="head_12" select="parent::sentence/word[@id = $head_11]/@head"/>
                        <xsl:variable name="head_13" select="parent::sentence/word[@id = $head_12]/@head"/>
                        <xsl:variable name="head_14" select="parent::sentence/word[@id = $head_13]/@head"/>
                        <xsl:variable name="head_15" select="parent::sentence/word[@id = $head_14]/@head"/>
                        <xsl:variable name="head_16" select="parent::sentence/word[@id = $head_15]/@head"/>
                        
                        <word>
                            <xsl:copy-of select="@*"/>
                            <geodesic>
                                <xsl:choose>
                                    <xsl:when test="$head_16 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_15]/@id,
                                            parent::sentence/word[@id = $head_14]/@id,
                                            parent::sentence/word[@id = $head_13]/@id,
                                            parent::sentence/word[@id = $head_12]/@id,
                                            parent::sentence/word[@id = $head_11]/@id,
                                            parent::sentence/word[@id = $head_10]/@id,
                                            parent::sentence/word[@id = $head_9]/@id,
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    
                                    <xsl:when test="$head_15 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_14]/@id,
                                            parent::sentence/word[@id = $head_13]/@id,
                                            parent::sentence/word[@id = $head_12]/@id,
                                            parent::sentence/word[@id = $head_11]/@id,
                                            parent::sentence/word[@id = $head_10]/@id,
                                            parent::sentence/word[@id = $head_9]/@id,
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_14 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_13]/@id,
                                            parent::sentence/word[@id = $head_12]/@id,
                                            parent::sentence/word[@id = $head_11]/@id,
                                            parent::sentence/word[@id = $head_10]/@id,
                                            parent::sentence/word[@id = $head_9]/@id,
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_13 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_12]/@id,
                                            parent::sentence/word[@id = $head_11]/@id,
                                            parent::sentence/word[@id = $head_10]/@id,
                                            parent::sentence/word[@id = $head_9]/@id,
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    
                                    <xsl:when test="$head_12 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_11]/@id,
                                            parent::sentence/word[@id = $head_10]/@id,
                                            parent::sentence/word[@id = $head_9]/@id,
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_11 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_10]/@id,
                                            parent::sentence/word[@id = $head_9]/@id,
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    
                                    <xsl:when test="$head_10 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_9]/@id,
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_9 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_8]/@id,
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_8 = 0">
                                        <xsl:value-of select="string-join(( 
                                           
                                            parent::sentence/word[@id = $head_7]/@id,
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_7 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_6]/@id,
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_6 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_5]/@id,
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_5 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_4]/@id,
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_4 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_3]/@id,
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_3 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_2]/@id,
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_2 = 0">
                                        <xsl:value-of select="string-join(( 
                                            parent::sentence/word[@id = $head_1]/@id,
                                            ./@id ), ' ')"/>                                       
                                        
                                    </xsl:when>
                                    <xsl:when test="$head_1 = 0">
                                        <xsl:value-of select="./@id"/>                                       
                                        
                                    </xsl:when>
                                    
                                    
                                    <xsl:otherwise>poop</xsl:otherwise>
                                </xsl:choose>
                            </geodesic>
                        </word>
                        
                    </xsl:for-each>
                    
                </sentence>
            </xsl:for-each>
            
            
        </projectivity_document>
        
        
    </xsl:template>
    
</xsl:stylesheet>