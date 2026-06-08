/**
 * @file signal_pool.c
 * @brief Definition of signal pool with mapping and get functions.
 *
 * @copyright Copyright (c) 2020 by elobau GmbH & Co. KG
 *
 * All rights reserved.  Protected by international copyright laws.
 * Knowledge of the source code may not be used to write a similar product.
 * This file may only be used in accordance with a license and should not be
 * redistributed in any way.
 */
#include "signal_pool.h"
#include "float.h"
#include "signal_pool_cfg.h"
#include <stdint.h>
#include <stdlib.h>

/**
 * @brief Declaration of a single signal.
 */
typedef struct
{
    sp_signal_type_t  signal_type;
    uint32_t  signal_id;
    union vals_x /* parasoft-suppress MISRAC2012-RULE_19_2-a "the dataencapsulation in this module ensures that just like in signal type configured values are assigned and read ( no type conversation with union)." */
    {
        uint32_t  val_uint32;
        float32_t val_float;
    } z;
} signal_t;


/**
 * @brief Declaration of a memory map which is composed of SP_NR_OF_MEM_CELLS of signals.
 */
typedef struct
{
    signal_t values[SP_NR_OF_MEM_CELLS];
} memory_t;

/**
 * @brief Declaration of a single signal_pool which is a slice of the memory.
 */
typedef struct signal_pool /* parasoft-suppress CODSTA-47 "Structure is typedef'd in header file" */
{
    size_t size;
    uint32_t start;
    uint32_t end;
} signal_pool_t;

/*  -----------------------  LOCAL DATA          --------------------------  */
/** Instance for the memory, which stores all signal pools */
static memory_t  pool_memory[sig_nr_max];

/** the meta information which holds the ranges of the signals. */
static signal_pool_t  configs[(uint32_t)sp_complete_pool + 1u];


/**
 * @brief Initialize the memory pool
 *
 * @param[in]  sig_pool  Related signal pool index
 * @return  bool  Returns unconditional true
 */
static bool init_pool_memory(const sig_nr_pools_t sig_pool)
{
    bool init_ok = true;
    size_t offset = 0; // hint: the offset depends on datatype size

    if (sig_pool >= sig_nr_max)
    {
        /* Invalid signal pool index */
        init_ok = false;
    }
    else
    {
        for (uint32_t i = 0uL; i < SP_NR_OF_MEM_CELLS; i++)
        {
            pool_memory[sig_pool].values[i].signal_type = invalid;
            pool_memory[sig_pool].values[i].signal_id = i;  // signal identifier is the index
        }

        // Determine the config information which holds the ranges of the signals
        // sp_complete_pool is the last element of the enum sig_config_t: describes the full pool
        for (uint32_t i = 0; i < ((uint32_t)sp_complete_pool + 1u); i++)
        {
            configs[i].start = offset;
            /* set start to 0 for the complete pool */
            if (i == sp_complete_pool)
            {
                configs[i].start = 0;
            }
            configs[i].size = sp_cfg_get_range_size((sig_config_t)i); /* parasoft-suppress MISRAC2012-RULE_10_5-a "Cast is ok, is checked in loop" */

            if (configs[i].size > (SIZE_MAX - offset))
            {
                init_ok = false;
                break;
            }

            configs[i].end = offset + configs[i].size;
            offset += configs[i].size;
        }
    }

    return init_ok;
}

/*  ---------------  ONE GLOBAL FUNCTION BETWEEN    -----------------------  */
/**
 * @brief  Get the signal pool object Returns the configuration of a signal pool.
 *
 * @param[in]  sig_pool      Related signal pool index
 * @param[in]  signal_range  The signal pool of interest.
 * @return  signal_pool_t*  Returns the Ptr configuration if initialized, -- otherwise NULL
 */
const signal_pool_t *sp_init_range(const sig_nr_pools_t sig_pool, const sig_config_t signal_range)
{
    const signal_pool_t *p_cfg;
    static bool memory_is_initialized[sig_nr_max] = {false};

    if ((signal_range > sp_complete_pool) || (sig_pool >= sig_nr_max))
    {
        p_cfg = NULL;
    }
    else
    {
        p_cfg = &configs[signal_range];
        // Initialize the memory just once
        if (memory_is_initialized[sig_pool] == false)
        {
            if (init_pool_memory(sig_pool))
            {
                memory_is_initialized[sig_pool] = true;
            }
            else /* memory initalization failed */
            {
                /* set pointer to NULL to produce error */
                p_cfg = NULL;
            }
        }
    }


    return p_cfg;
}

/*  -----------------------  ONE LOCAL FUNCTION      ----------------------  */
/**
 * @brief Check the parameters if they are in range and the signal is configured correctly.
 *
 * @param[in]  sig_pool  Related signal pool index
 * @param[in]  range     The signal range.
 * @param[in]  sig_nr  The signal number which the callee wants to access.
 * @return  sp_result_t  Returns if success: ERR_SP_SUCCESS,
 *                       -- error-1: ERR_SP_SIG_OUT_OF_RANGE
 *                       -- error-2: ERR_SP_SIG_INVALID
 */
static sp_result_t check_accessor_par(const sig_nr_pools_t sig_pool,
        const sig_config_t range, const uint32_t sig_nr)
{
    sp_result_t ret_val = ERR_SP_SUCCESS;  // Local return variable init with ERR_SP_SUCCESS

    const size_t start_range = sp_cfg_get_range_begin(range);
    const size_t end_range = sp_cfg_get_range_end(range);

    // Parameter check
    if ((sig_nr > end_range)
        || (sig_nr < start_range)
        || (sig_nr >= SP_NR_OF_MEM_CELLS)
        || (sig_pool >= sig_nr_max))
    {
        ret_val = ERR_SP_SIG_OUT_OF_RANGE;
    }
    else if (pool_memory[sig_pool].values[sig_nr].signal_id != sig_nr)
    {
        ret_val = ERR_SP_SIG_INVALID;
    }
    else
    {
        /* intentional left blank */;
    }

    return ret_val;
}



/*  -----------------------  GLOBAL FUNCTIONS    --------------------------  */

/**
 * @brief  Set the signal type object
 *
 * @param[in]  sig_pool The related signal pool
 * @param[in]  range    The signal range where the signal is contained
 * @param[in]  begin_range The start of the range
 * @param[in]  end_range  The end of the range
 * @param[in]  type       type of the signal
 * @return  sp_result_t success: ERR_SP_SUCCESS
 *                        error: ERR_SP_GENERIC_ERROR or error from called check_accessor_par()
 */
sp_result_t set_signal_type(const sig_nr_pools_t sig_pool, const sig_config_t range, const uint32_t begin_range,
        const uint32_t end_range, const sp_signal_type_t type)
{
    sp_result_t ret_val = check_accessor_par(sig_pool, range, begin_range);
    ret_val |= check_accessor_par(sig_pool, range, end_range);

    if (ret_val == ERR_SP_SUCCESS)
    {
        for (uint32_t i = begin_range; i < end_range; i++)
        {
            if (pool_memory[sig_pool].values[i].signal_type == invalid)
            {
                pool_memory[sig_pool].values[i].signal_type = type;
            }
            else
            {
                // If the client tries to configure datatype twice.
                ret_val = ERR_SP_GENERIC_ERROR;
                break;
            }
        }
    }

    return ret_val;
}

/**
 * @brief Get the signal float object
 *
 * @param[in]  sig_pool The related signal pool
 * @param[in]  range    The signal range where the signal is contained
 * @param[in]  sig_nr   The signal nr of the wanted signal
 * @param[out]  value  Ptr-float32_t  Points to relevant output signal
 * @return sp_result_t if success: SP_SUCCESS
 *                        error: the error.
 */
sp_result_t get_signal_float(const sig_nr_pools_t sig_pool, const sig_config_t range,
        const uint32_t sig_nr, float32_t *const value)
{
    sp_result_t ret_val = ERR_SP_SUCCESS;

    if (NULL != value)
    {
        ret_val = check_accessor_par(sig_pool, range, sig_nr);

        if (ERR_SP_SUCCESS == ret_val)
        {
            if (ffp32 == pool_memory[sig_pool].values[sig_nr].signal_type)
            {
                *value = pool_memory[sig_pool].values[sig_nr].z.val_float;
            }
            else
            {
                ret_val = ERR_SP_INVALID_DTYPE;
            }
        }
    }
    else
    {
        ret_val = ERR_SP_GENERIC_ERROR;
    }

    return ret_val;
}

/**
 * @brief This function assigns the value address of sig_nr to map_target.
 *        Before returning the address sanity checks are done.
 *
 *        The sig_nr needs to be contained in the signal_pool_t range it needs
 *        to be initialized as float, and the map_target needs to point to a pointer.
 *
 * @param[in]  sig_pool The related signal pool
 * @param[in]  range The signal range where the signal is contained
 * @param[in]  sig_nr The signal nr which should be mapped
 * @param[out]  map_target  Ptr-float32_t  The address is written if map_target unequal NULL
 *                          and return value fct call check_accessor_par(.) is ERR_SP_SUCCESS
 * @return sp_result_t  Returns in normal case: ERR_SP_SUCCESS,
 *                        error: ERR_SP_GENERIC_ERROR, ERR_SP_INVALID_DTYPE or error from called check_accessor_par()
 */
sp_result_t map_raw_float_rw(const sig_nr_pools_t sig_pool, const sig_config_t range,
        const uint32_t sig_nr, float32_t **map_target)
{
    sp_result_t ret_val = ERR_SP_SUCCESS;

    if (NULL != map_target)
    {
        ret_val = check_accessor_par(sig_pool, range, sig_nr);

        if (ret_val == ERR_SP_SUCCESS)
        {
            if (ffp32 == pool_memory[sig_pool].values[sig_nr].signal_type)
            {
                *map_target = &pool_memory[sig_pool].values[sig_nr].z.val_float;
            }
            else
            {
                ret_val = ERR_SP_INVALID_DTYPE;
            }
        }
    }
    else
    {
        ret_val = ERR_SP_GENERIC_ERROR;
    }

    return ret_val;
}

/**
 * @brief  Set the signal float type
 *
 * @param[in]  sig_pool The related signal pool
 * @param[in]  range    The signal range which contains sig_nr
 * @param[in]  sig_nr   sig_nr which needs to be configured correctly.
 * @param[in]  value    value to write.
 * @return sp_result_t  Returns in normal case: ERR_SP_SUCCESS otherwise: error value.
 */
sp_result_t set_signal_float(const sig_nr_pools_t sig_pool, const sig_config_t range,
        const uint32_t sig_nr, const float32_t value)
{
    sp_result_t ret_val = check_accessor_par(sig_pool, range, sig_nr);

    if (ERR_SP_SUCCESS == ret_val)
    {
        if (ffp32 == pool_memory[sig_pool].values[sig_nr].signal_type)
        {
            pool_memory[sig_pool].values[sig_nr].z.val_float = value;
        }
        else
        {
            ret_val = ERR_SP_INVALID_DTYPE;
        }
    }

    return ret_val;
}

/**
 * @brief  Get the signal uint32_t object
 *
 * @param[in] sig_pool The related signal pool
 * @param[in] range    The signal range where the signal is contained
 * @param[in] sig_nr   The signal nr of the wanted signal
 * @param[out]  value  Ptr-u32  Points to memory element
 * @return sp_result_t  Returns in normal case: ERR_SP_SUCCESS otherwise: error value.
 */
sp_result_t get_signal_uint32(const sig_nr_pools_t sig_pool, const sig_config_t range,
        const uint32_t sig_nr, uint32_t *const value)
{
    sp_result_t ret_val = ERR_SP_SUCCESS;

    if (NULL != value)
    {
        ret_val = check_accessor_par(sig_pool, range, sig_nr);

        if (ERR_SP_SUCCESS == ret_val)
        {
            if (uint32 == pool_memory[sig_pool].values[sig_nr].signal_type)
            {
                *value = pool_memory[sig_pool].values[sig_nr].z.val_uint32;
            }
            else
            {
                ret_val = ERR_SP_INVALID_DTYPE;
            }
        }
    }
    else
    {
        ret_val = ERR_SP_GENERIC_ERROR;
    }

    return ret_val;
}

/**
 * @brief This function assigns the value address of sig_nr to map_target.
 *        Before returning the address sanity checks are done.
 *
 *        The sig_nr needs to be contained in the signal_pool_t range it needs
 *        to be initialized as uint32, and the map_target needs to point to a pointer.
 *
 * @param[in]  sig_pool The related signal pool
 * @param[in]  range    The signal range where the signal is contained
 * @param[in]  sig_nr   The signal nr which should be mapped
 * @param[out] map_target  Ptr-u32  The address is written if ret_val is ERR_SP_SUCCESS
 *                         and signal_type is uint32
 * @return sp_result_t  Returns in normal case: ERR_SP_SUCCESS
 *                        error: ERR_SP_GENERIC_ERROR, ERR_SP_INVALID_DTYPE or error from called check_accessor_par()
 */
sp_result_t map_raw_uint32_rw(const sig_nr_pools_t sig_pool, const sig_config_t range,
        const uint32_t sig_nr, uint32_t **map_target)
{
    sp_result_t ret_val = ERR_SP_SUCCESS;

    if (NULL != map_target)
    {
        ret_val = check_accessor_par(sig_pool, range, sig_nr);

        if (ERR_SP_SUCCESS == ret_val)
        {
            if (uint32 == pool_memory[sig_pool].values[sig_nr].signal_type)
            {
                *map_target = &pool_memory[sig_pool].values[sig_nr].z.val_uint32;
            }
            else
            {
                ret_val = ERR_SP_INVALID_DTYPE;
            }
        }
    }
    else
    {
        ret_val = ERR_SP_GENERIC_ERROR;
    }

    return ret_val;
}

/**
 * @brief  Set the signal uint32
 *
 * @param[in]  sig_pool  Related signal pool index (number)
 * @param[in]  range     The signal range which contains sig_nr
 * @param[in]  sig_nr    signal number which needs to be configured correctly.
 * @param[in]  value  u32  value to write.
 * @return  sp_result_t  if success: ERR_SP_SUCCESS otherwise: error value.
 */
sp_result_t set_signal_uint32(const sig_nr_pools_t sig_pool, const sig_config_t range,
        const uint32_t sig_nr, const uint32_t value)
{
    sp_result_t ret_val = check_accessor_par(sig_pool, range, sig_nr);

    if (ERR_SP_SUCCESS == ret_val)
    {
        if (uint32 == pool_memory[sig_pool].values[sig_nr].signal_type)
        {
            pool_memory[sig_pool].values[sig_nr].z.val_uint32 = value;
        }
        else
        {
            ret_val = ERR_SP_INVALID_DTYPE;
        }
    }

    return ret_val;
}
