/*****************************************************************************
 * Copyright    : 
 *****************************************************************************/

/*****************************************************************************
 * File                 : sample.c
 * Module               : 
 * Description          : Sample file
 *               
 * Author               : Punith
 *
 * Revision History     : $Id: $
 * Initial release      : 
 * Bug Number           : 
 * Fixed by             : 
 * Change in File       : 
 *****************************************************************************/

/*#include <system_include.h>
#include "user_include.h"*/

/*  Constant macros     */

/*  Function macros     */

/*  typedefs            */

/*  enums               */

/*    Definition of global Variables in the following sequence order */
/*  Global External Data Declaration */

/*  Static globals */


/*    Extern function prototypes    */

/*    Static function prototypes    */

/*    function prototypes           */


/*    function definition           */
/*****************************************************************************
 * Function Name        :
 * Return Values        :
 * Global variables     :   None
 * of the <SUB-MODULE>
 * Global variables     :   None
 * of <MODULE>  
 * Global variables     :   None
 * of <PRODUCT> 
 * Description          :   Sample Function.
 *
 ****************************************************************************/
int sample(int iCount)
{
    int iNum = 0;
    int iTrue = 1;
    if(iTrue)
    {
        /*
         *  Sample Comment
         */
        for(iNum = 0; iNum < iCount; iNum++)
        {
            /* No action */

        }/* end of for(iNum = 0; iNum < iCount; iNum++) */


        while(iCount)   /* Or Like this */
        {
            iCount--;
        }/* end of while(iCount) */

    }/* end of if(iTrue) */

    return 0;
}/* end of sample() */

/************************* End of File sample.c ******************************/
