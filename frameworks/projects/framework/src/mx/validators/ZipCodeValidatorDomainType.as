
package mx.validators
{

/**
 *  The ZipCodeValidatorDomainType class defines the values 
 *  for the <code>domain</code> property of the ZipCodeValidator class,
 *  which you use to specify the type of ZIP code to validate.
 *
 *  @see mx.validators.ZipCodeValidator
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public final class ZipCodeValidatorDomainType
{
	include "../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Class constants
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Specifies to validate a United States or Canadian ZIP code.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public static const US_OR_CANADA:String = "US or Canada";
	
	/**
	 *  Specifies to validate a United States ZIP code.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public static const US_ONLY:String = "US Only";
	
	/**
	 *  Specifies to validate a Canadian ZIP code.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public static const CANADA_ONLY:String = "Canada Only";
}

}