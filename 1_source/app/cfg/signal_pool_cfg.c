/* parasoft-begin-suppress eloRules-1 "using old coding guideline" */
/**
 * @file signal_pool_cfg.c
 * @brief Definition of the signal pool configuration.
 *
 * @copyright Copyright (c) 2020 by elobau GmbH & Co. KG
 *
 * All rights reserved.  Protected by international copyright laws.
 * Knowledge of the source code may not be used to write a similar product.
 * This file may only be used in accordance with a license and should not be
 * redistributed in any way.
 */
#include "signal_pool_cfg.h"


#include <stdint.h>

typedef enum
{
    sp_begin = 0,
    sp_end = 1,
    sp_boundaries
}sp_boundaries_t; /* parasoft-suppress MISRAC2012-RULE_2_3-b "only elements of structure are used" */


/* parasoft-begin-suppress CODSTA-29 "Definition of signal pool" */
static size_t config_size[(uint32_t)sp_complete_pool + 1u][sp_boundaries] = {
{0, 2}, // sp_v_test_0_input
{2, 5}, // sp_btn_row1_input
{5, 8}, // sp_btn_row2_input
{8, 11}, // sp_btn_row3_input
{11, 14}, // sp_btn_row4_input
{14, 17}, // sp_enc_input
{17, 18}, // sp_spare1_input
{18, 19}, // sp_v_test_7_input
{19, 20}, // sp_hwver_input
{20, 21}, // sp_temp_input
{21, 23}, // sp_v_sbc_0_input
{23, 25}, // sp_v_sbc_1_input
{25, 27}, // sp_v_sbc_2_input
{27, 29}, // sp_v_sbc_3_input
{29, 33}, // sp_3dh0_1_input
{33, 37}, // sp_3dh1_1_input
{37, 41}, // sp_3dh2_1_input
{41, 45}, // sp_3dh3_1_input
{45, 49}, // sp_3dh0_2_input
{49, 53}, // sp_3dh1_2_input
{53, 57}, // sp_3dh2_2_input
{57, 61}, // sp_3dh3_2_input
{61, 63}, // sp_2dh0_1_input
{63, 65}, // sp_2dh1_1_input
{65, 67}, // sp_2dh0_2_input
{67, 69}, // sp_2dh1_2_input
{69, 195}, // sp_capsense_input
{195, 228}, // sp_capsense_g_input
{228, 248}, // sp_capsense_heating_input
{248, 249}, // sp_voltage0_input
{249, 250}, // sp_voltage1_input
{250, 253}, // sp_heating_temp_input
{253, 254}, // sp_voltage3_input
{254, 255}, // sp_v_test_0_output
{255, 258}, // sp_btn_row1_output
{258, 261}, // sp_btn_row2_output
{261, 264}, // sp_btn_row3_output
{264, 267}, // sp_btn_row4_output
{267, 269}, // sp_enc_output
{269, 270}, // sp_spare1_output
{270, 271}, // sp_v_test_7_output
{271, 272}, // sp_hwver_output
{272, 273}, // sp_temp_output
{273, 274}, // sp_v_sbc_0_output
{274, 275}, // sp_v_sbc_1_output
{275, 276}, // sp_v_sbc_2_output
{276, 277}, // sp_v_sbc_3_output
{277, 297}, // sp_3dh0_output
{297, 317}, // sp_3dh1_output
{317, 337}, // sp_3dh2_output
{337, 357}, // sp_3dh3_output
{357, 358}, // sp_3dh0_z_output
{358, 359}, // sp_3dh1_z_output
{359, 360}, // sp_3dh2_z_output
{360, 361}, // sp_3dh3_z_output
{361, 381}, // sp_2dh0_output
{381, 401}, // sp_2dh1_output
{401, 409}, // sp_capsense_output
{409, 410}, // sp_capsense_g_output
{410, 411}, // sp_capsense_heating_output
{411, 412}, // sp_voltage0_output
{412, 413}, // sp_voltage1_output
{413, 414}, // sp_voltage2_output
{414, 415}, // sp_voltage3_output
{0, 415}  // complete pool
    };
/* parasoft-end-suppress CODSTA-29 "Definition of signal pool" */

/**
 * @brief Returns the first signal id in a range
 *
 * @param range    The range of interest
 * @return size_t  First signal id in a range
 */
size_t sp_cfg_get_range_begin(const sig_config_t range)
{
    /**
     * Defines the size of the single ranges each size of a range is up
     * rounded to a multiple of '10' this makes it easier to grasp the
     * purpose of a signal for human being.
     */
    return config_size[range][sp_begin];
}

/**
 * @brief Returns the last signal id in a range
 *
 * @param range    The range of interest.
 * @return size_t  Last signal id in a range
 */
size_t sp_cfg_get_range_end(const sig_config_t range)
{
    return config_size[range][sp_end];
}

/**
 * @brief Returns the range of a signal id
 *
 * @param sig_nr    The signal number (id) of interest
 * @return sig_config_t  Corresponding range
 */
sig_config_t sp_cfg_get_range(const uint32_t sig_nr)
{
    sig_config_t  range = SP_START_INPUT;

    while (range < sp_complete_pool)
    {
        const uint32_t begin = sp_cfg_get_range_begin(range);
        const uint32_t end = sp_cfg_get_range_end(range);

        if ((sig_nr >= begin) && (sig_nr < end))  /* parameter sig_nr match with begin (enum value) ? */
        {
            break;  /* the range value at this program path is the Return value */
        }
        range++; /* parasoft-suppress MISRAC2012-RULE_10_1-d "Incrementing range" */
    }

    return range;
}

/**
 * @brief Returns the size of a range.
 *
 * @param range   The range of interest.
 * @return size_t Total number of signal ids in that range
 */
size_t sp_cfg_get_range_size(const sig_config_t range)
{
    return(config_size[range][sp_end] - config_size[range][sp_begin]);
}

/**
 * Converts a float32_t value to a uint32_t value
 * @param value
 * @param mult multiplier (to preserve decimal places)
 * @return value as uint32_t
 */
uint32_t convert_float(const float32_t value, const uint32_t mult)
{
    uint32_t result;
    int32_t signed_result;
    float32_t temp_result;


    temp_result = value * (float32_t)mult;
    if (temp_result > (float32_t)INT32_MAX)
    {
        temp_result = (float32_t)INT32_MAX;
    }
    else if (temp_result < (float32_t)INT32_MIN) /* parasoft-suppress MISRAC2012-RULE_10_1-e "usage of INT32_MIN from stdint.h"*/
    {
        temp_result = (float32_t)INT32_MIN; /* parasoft-suppress MISRAC2012-RULE_10_1-e "usage of INT32_MIN from stdint.h"*/
    }
    else
    {
        /* Value is within the range defined by INT32_MIN and INT32_MAX; no adjustment needed */
    }

    signed_result = (int32_t)temp_result;  /* parasoft-suppress MISRAC2012-RULE_10_8-a "Intended cast to int32_t" */
    result = (uint32_t)signed_result;  /* parasoft-suppress MISRAC2012-RULE_10_8-a "Intended cast to uint32_t" */


    return result;
}

#if defined(sp_diagnose)
/**
 * @brief Provides data from the signal pool for diagnosic services
 *
 * @param cRW read/write flag
 * @param p data record
 * @param pBuf send buffer
 * @param u32Len length
 * @return
 */
int16_t cb_did_signal_data(did_rw_flag_t cRW, const rec_dat_id_tbl_t *p, void *pBuf, uint32_t u32Len)
{
    int16_t rec_size = 0;
    uint8_t *loc_buf = (uint8_t *)pBuf;
    if (p->c_type == did_type_signal_pool)
    {
        sig_config_t range = (sig_config_t)(p->rec_data_id - (uint16_t)did_sp_v_test_0_input);
        uint32_t size = (uint32_t)sp_cfg_get_range_size(range);
        uint32_t sig_nr = (uint32_t)sp_cfg_get_range_begin(range);
        for (uint32_t i = 0; i < size; i++)
        {
            uint32_t data = 0;
            sp_result_t result = ERR_SP_SUCCESS;
            result = get_signal_uint32(range, (sig_nr + i), &data);
            if (result == ERR_SP_SUCCESS)
            {
                elo_memcpy(&loc_buf[rec_size], &data, sizeof(uint32_t));
                rec_size += sizeof(uint32_t);
            }
        }
    }
    else
    {
        rec_size = SRV_ERR_READ;
    }
    return rec_size;

}

#endif
