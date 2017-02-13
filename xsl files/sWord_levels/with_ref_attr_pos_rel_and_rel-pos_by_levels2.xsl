<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">


    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="treebank">
        <sWord_document>
            
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
                        <!-- This step creates variables containing the @id of the @head of each <word>. The process is recursive in that it
                        captures the @head attributes of all <word> elements from the target <word> to the root of the dependency tree.
                        For, example, variable $head_3 contains the @head attribute @id of the "parent"  of variable $head_2, which is the "parent" 
                        of the target <word> -->
                        <xsl:choose>
                            <xsl:when test="./@relation != 'AuxX'">

                                <xsl:variable name="head_1" select="./@head"/>
                                <xsl:variable name="head_2"
                                    select="parent::sentence/word[@id = $head_1]/@head"/>
                                <xsl:variable name="head_3"
                                    select="parent::sentence/word[@id = $head_2]/@head"/>
                                <xsl:variable name="head_4"
                                    select="parent::sentence/word[@id = $head_3]/@head"/>
                                <xsl:variable name="head_5"
                                    select="parent::sentence/word[@id = $head_4]/@head"/>
                                <xsl:variable name="head_6"
                                    select="parent::sentence/word[@id = $head_5]/@head"/>
                                <xsl:variable name="head_7"
                                    select="parent::sentence/word[@id = $head_6]/@head"/>
                                <xsl:variable name="head_8"
                                    select="parent::sentence/word[@id = $head_7]/@head"/>
                                <xsl:variable name="head_9"
                                    select="parent::sentence/word[@id = $head_8]/@head"/>
                                <xsl:variable name="head_10"
                                    select="parent::sentence/word[@id = $head_9]/@head"/>
                                <xsl:variable name="head_11"
                                    select="parent::sentence/word[@id = $head_10]/@head"/>
                                <xsl:variable name="head_12"
                                    select="parent::sentence/word[@id = $head_11]/@head"/>
                                <xsl:variable name="head_13"
                                    select="parent::sentence/word[@id = $head_12]/@head"/>
                                <xsl:variable name="head_14"
                                    select="parent::sentence/word[@id = $head_13]/@head"/>
                                <xsl:variable name="head_15"
                                    select="parent::sentence/word[@id = $head_14]/@head"/>
                                <xsl:variable name="head_16"
                                    select="parent::sentence/word[@id = $head_15]/@head"/>
                                <xsl:variable name="head_17"
                                    select="parent::sentence/word[@id = $head_16]/@head"/>
                                <xsl:variable name="head_18"
                                    select="parent::sentence/word[@id = $head_17]/@head"/>
                                <xsl:variable name="head_19"
                                    select="parent::sentence/word[@id = $head_18]/@head"/>
                                <xsl:variable name="head_20"
                                    select="parent::sentence/word[@id = $head_19]/@head"/>




                                <word>
                                    <!-- This step creates new <word> elements for the output file. The following line copies the attributes from the 
                                    original to the new <word> elements. -->
                                    <xsl:copy-of select="@*"/>

                                    <!-- The following block of code extracts the @relation and part of the @postag attributes from each imput 
                                    <word> element and creates child elements of teh <word> output. This child elements are <rel-pos-Sword-x> 
                                    elements (where x = the number steps from target word to root).  -->
                                    
                                    <rel-pos-sWord-0>
                                        <xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                        <!-- Each <word> element returns its own @relation and pos. These data are output as contents of 
                                        a <rel-pos-sWord-0> element. -->
                                        <xsl:value-of
                                            select="
                                                normalize-space(string-join((
                                                ./@relation,
                                                substring(./@postag, 1, 1)
                                                ), '-'))"
                                        > </xsl:value-of>
                                    </rel-pos-sWord-0>

                                    <!-- For all remaining sWord level elements, we first test to see if the level in question is the 
                                    sentence root. If so, we insert the root symbol (#)and terminate the output with the data
                                    of the <word> immediately dependent on the @head. Otherwise, the data for the "parent" word is included
                                    as well.  -->
                                    <rel-pos-sWord-1>
                                        <xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="$head_1 = 0">#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                > </xsl:value-of>
                                            </xsl:when>
                                            <xsl:when test="$head_1 > 0">
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </xsl:when>

                                        </xsl:choose>
                                    </rel-pos-sWord-1>
                                    <xsl:choose>
                                        <xsl:when test="$head_2 = 0">
                                            <rel-pos-sWord-2><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-2>
                                        </xsl:when>
                                        <xsl:when test="$head_2 > 0">
                                            <rel-pos-sWord-2><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-2>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_3 = 0">
                                            <rel-pos-sWord-3><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-3>
                                        </xsl:when>
                                        <xsl:when test="$head_3 > 0">
                                            <rel-pos-sWord-3><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-3>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_4 = 0">
                                            <rel-pos-sWord-4><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-4>
                                        </xsl:when>
                                        <xsl:when test="$head_4 > 0">
                                            <rel-pos-sWord-4><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-4>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_5 = 0">
                                            <rel-pos-sWord-5><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-5>
                                        </xsl:when>
                                        <xsl:when test="$head_5 > 0">
                                            <rel-pos-sWord-5><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-5>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_6 = 0">
                                            <rel-pos-sWord-6><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-6>
                                        </xsl:when>
                                        <xsl:when test="$head_6 > 0">
                                            <rel-pos-sWord-6><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-6>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_7 = 0">
                                            <rel-pos-sWord-7><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-7>
                                        </xsl:when>
                                        <xsl:when test="$head_7 > 0">
                                            <rel-pos-sWord-7><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-7>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_8 = 0">
                                            <rel-pos-sWord-8><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-8>
                                        </xsl:when>
                                        <xsl:when test="$head_8 > 0">
                                            <rel-pos-sWord-8><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-8>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_9 = 0">
                                            <rel-pos-sWord-9><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-9>
                                        </xsl:when>
                                        <xsl:when test="$head_9 > 0">
                                            <rel-pos-sWord-9><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-9>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_10 = 0">
                                            <rel-pos-sWord-10><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-10>
                                        </xsl:when>
                                        <xsl:when test="$head_10 > 0">
                                            <rel-pos-sWord-10><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-10>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_11 = 0">
                                            <rel-pos-sWord-11><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-11>
                                        </xsl:when>
                                        <xsl:when test="$head_11 > 0">
                                            <rel-pos-sWord-11><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-11>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_12 = 0">
                                            <rel-pos-sWord-12><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-12>
                                        </xsl:when>
                                        <xsl:when test="$head_12 > 0">
                                            <rel-pos-sWord-12><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-12>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_13 = 0">
                                            <rel-pos-sWord-13><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-13>
                                        </xsl:when>
                                        <xsl:when test="$head_13 > 0">
                                            <rel-pos-sWord-13><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-13>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_14 = 0">
                                            <rel-pos-sWord-14><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-14>
                                        </xsl:when>
                                        <xsl:when test="$head_14 > 0">
                                            <rel-pos-sWord-14><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-14>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_15 = 0">
                                            <rel-pos-sWord-15><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-15>
                                        </xsl:when>
                                        <xsl:when test="$head_15 > 0">
                                            <rel-pos-sWord-15><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-15>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_16 = 0">
                                            <rel-pos-sWord-16><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-16>
                                        </xsl:when>
                                        <xsl:when test="$head_16 > 0">
                                            <rel-pos-sWord-16><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-16>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_17 = 0">
                                            <rel-pos-sWord-17><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-17>
                                        </xsl:when>
                                        <xsl:when test="$head_17 > 0">
                                            <rel-pos-sWord-17><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-17>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_18 = 0">
                                            <rel-pos-sWord-18><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-18>
                                        </xsl:when>
                                        <xsl:when test="$head_18 > 0">
                                            <rel-pos-sWord-18><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-18>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_19 = 0">
                                            <rel-pos-sWord-19><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-19>
                                        </xsl:when>
                                        <xsl:when test="$head_19 > 0">
                                            <rel-pos-sWord-19><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_19]/@relation,
                                                        substring(parent::sentence/word[@id = $head_19]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-19>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_20 = 0">
                                            <rel-pos-sWord-20><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_19]/@relation,
                                                        substring(parent::sentence/word[@id = $head_19]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-20>
                                        </xsl:when>
                                        <xsl:when test="$head_20 > 0">
                                            <rel-pos-sWord-20><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_20]/@relation,
                                                        substring(parent::sentence/word[@id = $head_20]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_19]/@relation,
                                                        substring(parent::sentence/word[@id = $head_19]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        ./@relation,
                                                        substring(./@postag, 1, 1)
                                                        ), '-'))"
                                                />
                                            </rel-pos-sWord-20>
                                        </xsl:when>
                                    </xsl:choose>
                                    
                                    <!-- End of rel-pos-sWord block of test -->
                                    
                                    
                                    <!-- Here we add sWord levels for @relation attributes without pos data.  -->

                                    <!-- BEGGINING OF rel-sWord CODE BLOCK -->

                                    <rel-sWord-0><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                        <!-- Each <word> element returns its own @relation. These data are output as contents of 
                                        a <rel-sWord-0> element. -->
                                        <xsl:value-of select="./@relation"/>
                                    </rel-sWord-0>

                                    <!-- For all remaining sWord level elements, we first test to see if the level in question is the 
                                    sentence root. If so, we insert the root symbol (#)and terminate the output with the data
                                    of the <word> immediately dependent on the @head. Otherwise, the data for the "parent" word is included
                                    as well.  -->
                                    <rel-sWord-1><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="$head_1 = 0">#-<xsl:value-of
                                                  select="./@relation"> </xsl:value-of>
                                            </xsl:when>
                                            <xsl:when test="$head_1 > 0">
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_1]/@relation,                                                        
                                                        ./@relation                                                        
                                                        ), '-')"
                                                />
                                            </xsl:when>

                                        </xsl:choose>
                                    </rel-sWord-1>
                                    <xsl:choose>
                                        <xsl:when test="$head_2 = 0">
                                            <rel-sWord-2><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-2>
                                        </xsl:when>
                                        <xsl:when test="$head_2 > 0">
                                            <rel-sWord-2><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-2>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_3 = 0">
                                            <rel-sWord-3><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-3>
                                        </xsl:when>
                                        <xsl:when test="$head_3 > 0">
                                            <rel-sWord-3><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-3>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_4 = 0">
                                            <rel-sWord-4><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-4>
                                        </xsl:when>
                                        <xsl:when test="$head_4 > 0">
                                            <rel-sWord-4><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-4>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_5 = 0">
                                            <rel-sWord-5><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-5>
                                        </xsl:when>
                                        <xsl:when test="$head_5 > 0">
                                            <rel-sWord-5><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-5>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_6 = 0">
                                            <rel-sWord-6><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-6>
                                        </xsl:when>
                                        <xsl:when test="$head_6 > 0">
                                            <rel-sWord-6><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-6>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_7 = 0">
                                            <rel-sWord-7><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-7>
                                        </xsl:when>
                                        <xsl:when test="$head_7 > 0">
                                            <rel-sWord-7><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-7>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_8 = 0">
                                            <rel-sWord-8><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-8>
                                        </xsl:when>
                                        <xsl:when test="$head_8 > 0">
                                            <rel-sWord-8><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-8>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_9 = 0">
                                            <rel-sWord-9><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        normalize-space(string-join((
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-'))"
                                                />
                                            </rel-sWord-9>
                                        </xsl:when>
                                        <xsl:when test="$head_9 > 0">
                                            <rel-sWord-9><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-9>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_10 = 0">
                                            <rel-sWord-10><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-10>
                                        </xsl:when>
                                        <xsl:when test="$head_10 > 0">
                                            <rel-sWord-10><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-10>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_11 = 0">
                                            <rel-sWord-11><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-11>
                                        </xsl:when>
                                        <xsl:when test="$head_11 > 0">
                                            <rel-sWord-11><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-11>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_12 = 0">
                                            <rel-sWord-12><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-12>
                                        </xsl:when>
                                        <xsl:when test="$head_12 > 0">
                                            <rel-sWord-12><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                       string-join((
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-12>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_13 = 0">
                                            <rel-sWord-13><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-13>
                                        </xsl:when>
                                        <xsl:when test="$head_13 > 0">
                                            <rel-sWord-13><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-13>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_14 = 0">
                                            <rel-sWord-14><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-14>
                                        </xsl:when>
                                        <xsl:when test="$head_14 > 0">
                                            <rel-sWord-14><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-14>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_15 = 0">
                                            <rel-sWord-15><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-15>
                                        </xsl:when>
                                        <xsl:when test="$head_15 > 0">
                                            <rel-sWord-15><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-15>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_16 = 0">
                                            <rel-sWord-16><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-16>
                                        </xsl:when>
                                        <xsl:when test="$head_16 > 0">
                                            <rel-sWord-16><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                         ), '-')"
                                                />
                                            </rel-sWord-16>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_17 = 0">
                                            <rel-sWord-17><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-17>
                                        </xsl:when>
                                        <xsl:when test="$head_17 > 0">
                                            <rel-sWord-17><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                       string-join((
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-17>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_18 = 0">
                                            <rel-sWord-18><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                       string-join((
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-18>
                                        </xsl:when>
                                        <xsl:when test="$head_18 > 0">
                                            <rel-sWord-18><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-18>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_19 = 0">
                                            <rel-sWord-19><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-19>
                                        </xsl:when>
                                        <xsl:when test="$head_19 > 0">
                                            <rel-sWord-19><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_19]/@relation,
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-19>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_20 = 0">
                                            <rel-sWord-20><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_19]/@relation,
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-20>
                                        </xsl:when>
                                        <xsl:when test="$head_20 > 0">
                                            <rel-sWord-20><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        parent::sentence/word[@id = $head_20]/@relation,
                                                        parent::sentence/word[@id = $head_19]/@relation,
                                                        parent::sentence/word[@id = $head_18]/@relation,
                                                        parent::sentence/word[@id = $head_17]/@relation,
                                                        parent::sentence/word[@id = $head_16]/@relation,
                                                        parent::sentence/word[@id = $head_15]/@relation,
                                                        parent::sentence/word[@id = $head_14]/@relation,
                                                        parent::sentence/word[@id = $head_13]/@relation,
                                                        parent::sentence/word[@id = $head_12]/@relation,
                                                        parent::sentence/word[@id = $head_11]/@relation,
                                                        parent::sentence/word[@id = $head_10]/@relation,
                                                        parent::sentence/word[@id = $head_9]/@relation,
                                                        parent::sentence/word[@id = $head_8]/@relation,
                                                        parent::sentence/word[@id = $head_7]/@relation,
                                                        parent::sentence/word[@id = $head_6]/@relation,
                                                        parent::sentence/word[@id = $head_5]/@relation,
                                                        parent::sentence/word[@id = $head_4]/@relation,
                                                        parent::sentence/word[@id = $head_3]/@relation,
                                                        parent::sentence/word[@id = $head_2]/@relation,
                                                        parent::sentence/word[@id = $head_1]/@relation,
                                                        ./@relation
                                                        ), '-')"
                                                />
                                            </rel-sWord-20>
                                        </xsl:when>
                                    </xsl:choose>

                                    <!-- END OF rel-sWord COD BLOCK -->
                                    
                                    <!-- The following block of text extracts the part of speech tag from the <word> elements. -->
                                    
                                    
                                    <pos-sWord-0><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                        <!-- Each <word> element returns its own @relation and pos. These data are output as contents of 
                                        a <rel-pos-sWord-0> element. -->
                                        <xsl:value-of
                                            select="
                                                string-join((
                                                substring(./@postag, 1, 1)
                                                ), '-')"
                                        > </xsl:value-of>
                                    </pos-sWord-0>

                                    <!-- For all remaining sWord level elements, we first test to see if the level in question is the 
                                    sentence root. If so, we insert the root symbol (#)and terminate the output with the data
                                    of the <word> immediately dependent on the @head. Otherwise, the data for the "parent" word is included
                                    as well.  -->
                                    <pos-sWord-1><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="$head_1 = 0">#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                > </xsl:value-of>
                                            </xsl:when>
                                            <xsl:when test="$head_1 > 0">
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </xsl:when>

                                        </xsl:choose>
                                    </pos-sWord-1>
                                    <xsl:choose>
                                        <xsl:when test="$head_2 = 0">
                                            <pos-sWord-2><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-2>
                                        </xsl:when>
                                        <xsl:when test="$head_2 > 0">
                                            <pos-sWord-2><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                       substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                       substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                       substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-2>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_3 = 0">
                                            <pos-sWord-3><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-3>
                                        </xsl:when>
                                        <xsl:when test="$head_3 > 0">
                                            <pos-sWord-3><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-3>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_4 = 0">
                                            <pos-sWord-4><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-4>
                                        </xsl:when>
                                        <xsl:when test="$head_4 > 0">
                                            <pos-sWord-4><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-4>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_5 = 0">
                                            <pos-sWord-5><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-5>
                                        </xsl:when>
                                        <xsl:when test="$head_5 > 0">
                                            <pos-sWord-5><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-5>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_6 = 0">
                                            <pos-sWord-6><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-6>
                                        </xsl:when>
                                        <xsl:when test="$head_6 > 0">
                                            <pos-sWord-6><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-6>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_7 = 0">
                                            <pos-sWord-7><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-7>
                                        </xsl:when>
                                        <xsl:when test="$head_7 > 0">
                                            <pos-sWord-7><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-7>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_8 = 0">
                                            <pos-sWord-8><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-8>
                                        </xsl:when>
                                        <xsl:when test="$head_8 > 0">
                                            <pos-sWord-8><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-8>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_9 = 0">
                                            <pos-sWord-9><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-9>
                                        </xsl:when>
                                        <xsl:when test="$head_9 > 0">
                                            <pos-sWord-9><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-9>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_10 = 0">
                                            <pos-sWord-10><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-10>
                                        </xsl:when>
                                        <xsl:when test="$head_10 > 0">
                                            <pos-sWord-10><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-10>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_11 = 0">
                                            <pos-sWord-11><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-11>
                                        </xsl:when>
                                        <xsl:when test="$head_11 > 0">
                                            <pos-sWord-11><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-11>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_12 = 0">
                                            <pos-sWord-12><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-12>
                                        </xsl:when>
                                        <xsl:when test="$head_12 > 0">
                                            <pos-sWord-12><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-12>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_13 = 0">
                                            <pos-sWord-13><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-13>
                                        </xsl:when>
                                        <xsl:when test="$head_13 > 0">
                                            <pos-sWord-13><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-13>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_14 = 0">
                                            <pos-sWord-14><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-14>
                                        </xsl:when>
                                        <xsl:when test="$head_14 > 0">
                                            <pos-sWord-14><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-14>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_15 = 0">
                                            <pos-sWord-15><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-15>
                                        </xsl:when>
                                        <xsl:when test="$head_15 > 0">
                                            <pos-sWord-15><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-15>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_16 = 0">
                                            <pos-sWord-16><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-16>
                                        </xsl:when>
                                        <xsl:when test="$head_16 > 0">
                                            <pos-sWord-16><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-16>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_17 = 0">
                                            <pos-sWord-17><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-17>
                                        </xsl:when>
                                        <xsl:when test="$head_17 > 0">
                                            <pos-sWord-17><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-17>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_18 = 0">
                                            <pos-sWord-18><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-18>
                                        </xsl:when>
                                        <xsl:when test="$head_18 > 0">
                                            <pos-sWord-18><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-18>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_19 = 0">
                                            <pos-sWord-19><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-19>
                                        </xsl:when>
                                        <xsl:when test="$head_19 > 0">
                                            <pos-sWord-19><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_19]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-19>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="$head_20 = 0">
                                            <pos-sWord-20><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>#-<xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_19]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-20>
                                        </xsl:when>
                                        <xsl:when test="$head_20 > 0">
                                            <pos-sWord-20><xsl:attribute name="ref"><xsl:value-of select="./@cite"/></xsl:attribute>
                                                <xsl:value-of
                                                  select="
                                                        string-join((
                                                        substring(parent::sentence/word[@id = $head_20]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_19]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_18]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_17]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_16]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_15]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_14]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_13]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_12]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_11]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_10]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_9]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_8]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_7]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_6]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_5]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_4]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_3]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_2]/@postag, 1, 1),
                                                        substring(parent::sentence/word[@id = $head_1]/@postag, 1, 1),
                                                        substring(./@postag, 1, 1)
                                                        ), '-')"
                                                />
                                            </pos-sWord-20>
                                        </xsl:when>
                                    </xsl:choose>

                                </word>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </sentence>
            </xsl:for-each>
        </sWord_document>
    </xsl:template>


</xsl:stylesheet>
