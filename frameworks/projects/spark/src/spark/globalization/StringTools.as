////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2010 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package spark.globalization
{

import flash.globalization.StringTools;

import mx.core.mx_internal;

import spark.globalization.LastOperationStatus;
import spark.globalization.supportClasses.GlobalizationBase;

use namespace mx_internal;

/**
 *  The <code>StringTools</code> class provides locale-sensitve case
 *  conversion methods.
 *
 *  <p>This class is a wrapper class around the
 *  <code>flash.globalization.StringTools</code>.
 *  Therefore the case conversion functionality is provided by the
 *  <code>flash.globalization.StringTools</code> class.
 *  However this <code>StringTools</code> class can be used in MXML
 *  declartions, uses the locale style for the requested Locale ID name, and
 *  has methods and properties that are bindable.
 *  Additionally events are generated if there is an error or warning
 *  generated by the flash.globalization class.</p>
 *
 *  <p>The <code>flash.globalization.StringTools</code> class use the
 *  underlying operating system for the case conversion functionality and
 *  On some operating systems, the <code>flash.globalization</code> classes
 *  are unsupported, this wrapper class provides fallback that makes use of
 *  the case conversion provided by the <code>String</code> class.</p>
 *
 *  @see flash.globalization.StringTools
 */
public class StringTools extends GlobalizationBase
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructs a new StringTools object that provides case conversion and
     *  other utilities according to the conventions of a given locale.
     *
     *  The locale for this class is supplied by the locale style.
     *  The locale style can be set in several ways:
     *
     *  <ul>
     *  <li>Inheriting the style from a UIComponent by calling the
     *  UIComponent's addStyleClient method.</li>
     *
     *  <li>By using the class in an MXML declaration and inheriting the
     *  locale from the document that contains the declaration.
     *  <listing version="3.0">
     *  &lt;fx:Declarations&gt;
     *         &lt;s:StringTools id="st" /&gt;
     *  &lt;/fx:Declarations&gt;
     *  </listing>
     *  </li>
     *
     *  <li>By using an MXML declaration and specifying the locale value in
     *  the list of assignments.
     *  <listing version="3.0">
     *  &lt;fx:Declarations&gt;
     *      &lt;s:StringTools id="st_turkish" locale="tr-TR" /&gt;
     *  &lt;/fx:Declarations&gt;
     *  </listing>
     *  </li>
     *
     *  <li>Calling the setStyle method, e.g.
     *  <code>st.setStyle("locale", "tr-TR")</code></li>
     *  </ul>
     *
     *  <p>If the locale style is not set by one of the above techniques, the
     *  methods of this class that depend on the locale will throw an
     *  error.</p>
     *
     *  @see flash.globalization.StringTools
     *  @see mx.core.UIComponent.addStyleClient
     *
     *  @playerversion Flash 10.1
     *  @langversion 3.0
     *  @productversion Flex 4.5
     *  @productversion Flash CS5
     */
    public function StringTools()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
      *  @private
      *  Actual instance of the working flash.globalization.StringTools
      *  instance.
      */
    private var g11nWorkingInstance:flash.globalization.StringTools;

    //--------------------------------------------------------------------------
    //
    //  Overridden Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  actualLocaleIDName
    //----------------------------------

    [Bindable("change")]

    /**
     *  @inheritDoc
     *
     *  @see flash.globalization.StringTools.actualLocaleIDName
     *  @see #StringTools()
     *
     *  @playerversion Flash 10.1
     *  @langversion 3.0
     *  @productversion Flash CS5
     *  @productversion Flex 4.5
     */
    override public function get actualLocaleIDName():String
    {
        if (g11nWorkingInstance)
            return this.g11nWorkingInstance.actualLocaleIDName;

        if ((localeStyle === undefined) || (localeStyle === null))
        {
            fallbackLastOperationStatus
                                = LastOperationStatus.LOCALE_UNDEFINED_ERROR;
            return undefined;
        }

        fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;

        return "en-US";
    }

    //----------------------------------
    //  lastOperationStatus
    //----------------------------------

    [Bindable("change")]

    /**
     *  @inheritDoc
     *
     *  @playerversion Flash 10.1
     *  @langversion 3.0
     *  @productversion Flash CS5
     *  @productversion Flex 4.5
     */
    override public function get lastOperationStatus():String
    {
        return g11nWorkingInstance ?
            g11nWorkingInstance.lastOperationStatus :
            fallbackLastOperationStatus;
    }

    //----------------------------------
    //  useFallback
    //----------------------------------

    [Bindable("change")]

    /**
     *  @private
     */
    override mx_internal function get useFallback():Boolean
    {
        return g11nWorkingInstance == null;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    override mx_internal function createWorkingInstance():void
    {
        if ((localeStyle === undefined) || (localeStyle === null))
        {
            fallbackLastOperationStatus
                                = LastOperationStatus.LOCALE_UNDEFINED_ERROR;
            g11nWorkingInstance = null;
            return;
        }

        if (enforceFallback)
        {
            fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;
            g11nWorkingInstance = null;
            return;
        }

        g11nWorkingInstance = new flash.globalization.StringTools(localeStyle);
        if (g11nWorkingInstance
            && (g11nWorkingInstance.lastOperationStatus
                                    != LastOperationStatus.UNSUPPORTED_ERROR))
        {
            propagateBasicProperties(g11nWorkingInstance);
            return;
        }

        fallbackLastOperationStatus = LastOperationStatus.USING_FALLBACK_WARNING;
        g11nWorkingInstance = null;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    [Bindable("change")]

    /**
     *  Converts a string to lowercase according to language conventions.
     *
     *  Depending on the locale, the output strin length can differ from the
     *  input string length.
     *
     *  @param s <code>String</code> to convert to lowercase.
     *  @return The converted lowercase string.
     *
     *  @see StringTools
     *
     *  @playerversion Flash 10.1
     *  @langversion 3.0
     *  @productversion Flex 4.5
     *  @productversion Flash CS5
     */
    public function toLowerCase(s:String):String
    {
        if (g11nWorkingInstance)
            return g11nWorkingInstance.toLowerCase(s);

        if ((localeStyle === undefined) || (localeStyle === null))
        {
            fallbackLastOperationStatus
                                = LastOperationStatus.LOCALE_UNDEFINED_ERROR;
            return undefined;
        }

        fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;

        return s.toLowerCase();
    }

    [Bindable("change")]

    /**
     *  Converts a string to uppercase according to language conventions.
     *
     *  Depending on the locale, the output strin length can differ from the
     *  input string length.
     *
     *  @param s <code>String</code> to convert to uppercase.
     *  @return The converted uppercase string.
     *
     *  @see StringTools
     *
     *  @playerversion Flash 10.1
     *  @langversion 3.0
     *  @productversion Flex 4.5
     *  @productversion Flash CS5
     */
    public function toUpperCase(s:String):String
    {
        if (g11nWorkingInstance)
            return g11nWorkingInstance.toUpperCase(s);

        if ((localeStyle === undefined) || (localeStyle === null))
        {
            fallbackLastOperationStatus
                                = LastOperationStatus.LOCALE_UNDEFINED_ERROR;
            return undefined;
        }

        fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;

        return s.toUpperCase();
    }

    /**
     *  @copy spark.utils.Collator#getAvailableLocaleIDNames
     *
     *  @playerversion Flash 10.1
     *  @langversion 3.0
     *  @productversion Flash CS5
     *  @productversion Flex 4.5
     */
    public static function getAvailableLocaleIDNames():Vector.<String>
    {
        const locales:Vector.<String>
                    = flash.globalization.Collator.getAvailableLocaleIDNames();

        return locales ? locales : new Vector.<String>["en-US"];
    }
}
}
