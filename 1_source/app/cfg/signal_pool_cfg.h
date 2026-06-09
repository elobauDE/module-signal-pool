/* parasoft-begin-suppress eloRules-1 "using old coding guideline" */
/**
 * @file signal_pool_cfg.h
 * @brief Definition signal pool config.
 *
 * @copyright Copyright (c) 2020 by elobau GmbH & Co. KG
 *
 * All rights reserved.  Protected by international copyright laws.
 * Knowledge of the source code may not be used to write a similar product.
 * This file may only be used in accordance with a license and should not be
 * redistributed in any way.
 */
#ifndef SIGNAL_POOL_CFG_H
#define SIGNAL_POOL_CFG_H

#include "util_float.h"

#include <stddef.h>
#include <stdint.h>

#define SP_START_OUT_CELL  254u
#define SP_NR_OF_MEM_CELLS 415u
#define SP_NR_OF_OUT_CELLS (SP_NR_OF_MEM_CELLS - SP_START_OUT_CELL)

#define SP_START_INPUT sp_v_test_0_input /*! Start of inputs */
#define SP_START_OUTPUT sp_v_test_0_output /*! Start of outputs */


#define SP_V_TEST_0_INPUT_SIZE        2u
#define SP_BTN_ROW1_INPUT_SIZE        3u
#define SP_BTN_ROW2_INPUT_SIZE        3u
#define SP_BTN_ROW3_INPUT_SIZE        3u
#define SP_BTN_ROW4_INPUT_SIZE        3u
#define SP_ENC_INPUT_SIZE        3u
#define SP_SPARE1_INPUT_SIZE        1u
#define SP_V_TEST_7_INPUT_SIZE        1u
#define SP_HWVER_INPUT_SIZE        1u
#define SP_TEMP_INPUT_SIZE        1u
#define SP_V_SBC_0_INPUT_SIZE        2u
#define SP_V_SBC_1_INPUT_SIZE        2u
#define SP_V_SBC_2_INPUT_SIZE        2u
#define SP_V_SBC_3_INPUT_SIZE        2u
#define SP_3DH0_1_INPUT_SIZE        4u
#define SP_3DH1_1_INPUT_SIZE        4u
#define SP_3DH2_1_INPUT_SIZE        4u
#define SP_3DH3_1_INPUT_SIZE        4u
#define SP_3DH0_2_INPUT_SIZE        4u
#define SP_3DH1_2_INPUT_SIZE        4u
#define SP_3DH2_2_INPUT_SIZE        4u
#define SP_3DH3_2_INPUT_SIZE        4u
#define SP_2DH0_1_INPUT_SIZE        2u
#define SP_2DH1_1_INPUT_SIZE        2u
#define SP_2DH0_2_INPUT_SIZE        2u
#define SP_2DH1_2_INPUT_SIZE        2u
#define SP_CAPSENSE_INPUT_SIZE        126u
#define SP_CAPSENSE_G_INPUT_SIZE        33u
#define SP_CAPSENSE_HEATING_INPUT_SIZE        20u
#define SP_VOLTAGE0_INPUT_SIZE        1u
#define SP_VOLTAGE1_INPUT_SIZE        1u
#define SP_HEATING_TEMP_INPUT_SIZE        3u
#define SP_VOLTAGE3_INPUT_SIZE        1u
#define SP_V_TEST_0_OUTPUT_SIZE        1u
#define SP_BTN_ROW1_OUTPUT_SIZE        3u
#define SP_BTN_ROW2_OUTPUT_SIZE        3u
#define SP_BTN_ROW3_OUTPUT_SIZE        3u
#define SP_BTN_ROW4_OUTPUT_SIZE        3u
#define SP_ENC_OUTPUT_SIZE        2u
#define SP_SPARE1_OUTPUT_SIZE        1u
#define SP_V_TEST_7_OUTPUT_SIZE        1u
#define SP_HWVER_OUTPUT_SIZE        1u
#define SP_TEMP_OUTPUT_SIZE        1u
#define SP_V_SBC_0_OUTPUT_SIZE        1u
#define SP_V_SBC_1_OUTPUT_SIZE        1u
#define SP_V_SBC_2_OUTPUT_SIZE        1u
#define SP_V_SBC_3_OUTPUT_SIZE        1u
#define SP_3DH0_OUTPUT_SIZE        20u
#define SP_3DH1_OUTPUT_SIZE        20u
#define SP_3DH2_OUTPUT_SIZE        20u
#define SP_3DH3_OUTPUT_SIZE        20u
#define SP_3DH0_Z_OUTPUT_SIZE        1u
#define SP_3DH1_Z_OUTPUT_SIZE        1u
#define SP_3DH2_Z_OUTPUT_SIZE        1u
#define SP_3DH3_Z_OUTPUT_SIZE        1u
#define SP_2DH0_OUTPUT_SIZE        20u
#define SP_2DH1_OUTPUT_SIZE        20u
#define SP_CAPSENSE_OUTPUT_SIZE        8u
#define SP_CAPSENSE_G_OUTPUT_SIZE        1u
#define SP_CAPSENSE_HEATING_OUTPUT_SIZE        1u
#define SP_VOLTAGE0_OUTPUT_SIZE        1u
#define SP_VOLTAGE1_OUTPUT_SIZE        1u
#define SP_VOLTAGE2_OUTPUT_SIZE        1u
#define SP_VOLTAGE3_OUTPUT_SIZE        1u

#if defined(sp_diagnose)
/* Forward declarations to avoid circular dependency with app_parameter.h */
typedef enum didrwflag did_rw_flag_t;
typedef struct rec_dat_id_tbl_s rec_dat_id_tbl_t;
#endif

typedef enum sig_nr_pools
{
    sig_pool_1 = 0x00,
    sig_pool_2,

    sig_nr_max
} sig_nr_pools_t;

typedef enum sig_config
{

    sp_v_test_0_input = 0x00,
    sp_btn_row1_input,/* adc temp intern */
    sp_btn_row2_input,
    sp_btn_row3_input,
    sp_btn_row4_input,
    sp_enc_input,
    sp_spare1_input,
    sp_v_test_7_input,
    sp_hwver_input,
    sp_temp_input,
    sp_v_sbc_0_input,
    sp_v_sbc_1_input,
    sp_v_sbc_2_input,
    sp_v_sbc_3_input,
    sp_3dh0_1_input,
    sp_3dh1_1_input,
    sp_3dh2_1_input,
    sp_3dh3_1_input,
    sp_3dh0_2_input,
    sp_3dh1_2_input,
    sp_3dh2_2_input,
    sp_3dh3_2_input,
    sp_2dh0_1_input,
    sp_2dh1_1_input,
    sp_2dh0_2_input,
    sp_2dh1_2_input,
    sp_capsense_input,
    sp_capsense_g_input,
    sp_capsense_heating_input,
    sp_voltage0_input,
    sp_voltage1_input,
    sp_heating_temp_input,
    sp_voltage3_input,
    sp_v_test_0_output,
    sp_btn_row1_output,
    sp_btn_row2_output,
    sp_btn_row3_output,
    sp_btn_row4_output,
    sp_enc_output,
    sp_spare1_output,
    sp_v_test_7_output,
    sp_hwver_output,
    sp_temp_output,
    sp_v_sbc_0_output,
    sp_v_sbc_1_output,
    sp_v_sbc_2_output,
    sp_v_sbc_3_output,
    sp_3dh0_output,
    sp_3dh1_output,
    sp_3dh2_output,
    sp_3dh3_output,
    sp_3dh0_z_output,
    sp_3dh1_z_output,
    sp_3dh2_z_output,
    sp_3dh3_z_output,
    sp_2dh0_output,
    sp_2dh1_output,
    sp_capsense_output,
    sp_capsense_g_output,
    sp_capsense_heating_output,
    sp_voltage0_output,
    sp_voltage1_output,
    sp_voltage2_output,
    sp_voltage3_output,
    sp_complete_pool,
} sig_config_t;

size_t sp_cfg_get_range_begin(const sig_config_t range);
size_t sp_cfg_get_range_end(const sig_config_t range);
sig_config_t sp_cfg_get_range(const uint32_t sig_nr);
size_t sp_cfg_get_range_size(const sig_config_t range);

uint32_t convert_float(const float32_t value, const uint32_t mult);

#if defined(sp_diagnose)
int16_t cb_did_signal_data(did_rw_flag_t cRW, const rec_dat_id_tbl_t *p, void *pBuf, uint32_t u32Len);
#endif

#endif  //!SIGNAL_POOL_CFG_H
