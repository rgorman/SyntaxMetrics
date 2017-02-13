<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
  
        
    
    <xsl:template match="treebank">
        <!-- Imput for this script is an xml file containing a treebank formatted accordint to the 
    conventions of the Ancient Languages Dependency Treebanks project. -->
        
        <sWord_document>
            <!--  Output of this script is an xml file of the type sWord_document. Metadata from imput file, 
                both at the level of the general file and the individual sentence, is preserved in the output file -->
            
            <xsl:copy-of select="@*"/>
            
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            
            <xsl:for-each select="sentence">
                <sentence>
                <xsl:copy-of select="@*"/>
                    
                <xsl:for-each select="word">
                    
                    <xsl:choose>
                        <xsl:when test="./@relation != 'AuxX'"> <!-- Commas annotated "AuxX" are excluded from transformation. -->
                        
                        <!-- Create variables containing idendification number of head word. Variable $head_1 contains the id of the parent
                            of the target word, $head_2 the id of the parent of the parent of the target word, etc. -->
                        
                                <xsl:variable name="head_1" select="./@head"/>
                                <xsl:variable name="head_2" select="parent::sentence/word[@id = $head_1]/@head"/>
                                <xsl:variable name="head_3" select="parent::sentence/word[@id = $head_2]/@head"/>
                                                          
                            
                            
                            
                            <word>
                                <xsl:copy-of select="@*"/>
                                       <!-- Each word element of the input document is reproduced with its attributes and their values. -->
                                <sWord>
                                    <!-- Each word element is given a sWord child element containing syntax data drawn from the inclusinve
                                    geodesic from target word to root. Different types of syntax data may be selected. -->
                                    
                                    <xsl:choose>
                                        <!-- Differnt blocks of code process input according to the destance from target word to root and 
                                            thus the length of the value of the resulting sWord.  -->
                                    <xsl:when test="$head_1=0">
                                        <!-- These blocks of code return the syntactic category "relation" from the geodesic path from 
                                        target word to root-->
                                        #-<xsl:value-of select="
                                                string-join((
                                                parent::sentence/word[@id = $head_1]/@relation,
                                                ./@relation
                                                ), '-')"></xsl:value-of>                                            
                                        </xsl:when>
                                        
                                        <xsl:when test="$head_2=0">
                                            #-<xsl:value-of select="
                                                string-join((
                                                parent::sentence/word[@id = $head_2]/@relation,
                                                parent::sentence/word[@id = $head_1]/@relation,
                                                ./@relation
                                                ), '-')"></xsl:value-of> 
                                            
                                        </xsl:when>
                                        <xsl:when test="$head_3=0">
                                            #-<xsl:value-of select="
                                                string-join((
                                                parent::sentence/word[@id = $head_3]/@relation,
                                                parent::sentence/word[@id = $head_2]/@relation,
                                                parent::sentence/word[@id = $head_1]/@relation,
                                                ./@relation
                                                ), '-')"></xsl:value-of>
                                        </xsl:when>        
                                    </xsl:choose>
                                </sWord>
                                
                            </word>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
                </sentence>
            </xsl:for-each>
        </sWord_document>
    </xsl:template>
</xsl:stylesheet>