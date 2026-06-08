/* parasoft-suppress eloRules-1 "using old coding guideline" */
/**
 * @file signal_pool.h
 * @brief signal pool with mapping and get functions.
 *
 * @copyright Copyright (c) 2020 by elobau GmbH & Co. KG
 *
 * All rights reserved.  Protected by international copyright laws.
 * Knowledge of the source code may not be used to write a similar product.
 * This file may only be used in accordance with a license and should not be
 * redistributed in any way.
 */
#ifndef SIGNAL_POOL_H
#define SIGNAL_POOL_H

#include "signal_pool_cfg.h"

#include "util_float.h"
#include <stdint.h>
#include <stdbool.h>


/** @defgroup  Signal pool error states
  * @{
  */
#define ERR_SP_SUCCESS           0u
#define ERR_SP_GENERIC_ERROR     1u
#define ERR_SP_INVALID_DTYPE     2u
#define ERR_SP_SIG_RANGE_EMPTY   3u
#define ERR_SP_SIG_OUT_OF_RANGE  4u
#define ERR_SP_SIG_INVALID       5u
/**
  * @}
  */

typedef uint32_t sp_result_t;

/**
 * @brief  signal type enumeration.
 */
typedef enum
{
    uint32,    /*!< 0 typedef enum */
    ffp32,     /*!< 1 typedef enum */
    ffp64,     /*!< 2 typedef enum */
    invalid    /*!< 3 typedef enum */
} sp_signal_type_t;


typedef struct signal_pool signal_pool_t;


/*  -----------------------  FUNCTION PROTOTYPES  -------------------------- */

const signal_pool_t *sp_init_range(const sig_nr_pools_t sig_pool, const sig_config_t signal_range);

/** Configure single signals */
sp_result_t set_signal_type(const sig_nr_pools_t sig_pool, const sig_config_t range, const uint32_t begin_range,
                            const uint32_t end_range, const sp_signal_type_t type);

sp_result_t get_signal_float(const sig_nr_pools_t sig_pool, const sig_config_t range,
                             const uint32_t sig_nr, float32_t *const value);
sp_result_t set_signal_float(const sig_nr_pools_t sig_pool, const sig_config_t range,
                             const uint32_t sig_nr, const float32_t value);

sp_result_t map_raw_float_rw(const sig_nr_pools_t sig_pool, const sig_config_t range,
                             const uint32_t sig_nr, float32_t **map_target);

sp_result_t get_signal_uint32(const sig_nr_pools_t sig_pool, const sig_config_t range,
                              const uint32_t sig_nr, uint32_t *const value);
sp_result_t set_signal_uint32(const sig_nr_pools_t sig_pool, const sig_config_t range,
                              const uint32_t sig_nr, const uint32_t value);

sp_result_t map_raw_uint32_rw(const sig_nr_pools_t sig_pool, const sig_config_t range,
                              const uint32_t sig_nr, uint32_t **map_target);


#endif  /* SIGNAL_POOL_H */
