-- VectorCAST 25.sp3 (07/01/25)
-- Test Case Script
--
-- Environment    : SIGNAL_POOL
-- Unit(s) Under Test: signal_pool
--
-- Script Features
TEST.SCRIPT_FEATURE:C_DIRECT_ARRAY_INDEXING
TEST.SCRIPT_FEATURE:CPP_CLASS_OBJECT_REVISION
TEST.SCRIPT_FEATURE:MULTIPLE_UUT_SUPPORT
TEST.SCRIPT_FEATURE:REMOVED_CL_PREFIX
TEST.SCRIPT_FEATURE:MIXED_CASE_NAMES
TEST.SCRIPT_FEATURE:STATIC_HEADER_FUNCS_IN_UUTS
TEST.SCRIPT_FEATURE:VCAST_MAIN_NOT_RENAMED
--

-- Unit: signal_pool

-- Subprogram: check_accessor_par

-- Test Case: check_accessor_par.001_sp_cfg_get_range_begin()_MIN__sp_cfg_get_range_end()_MIN
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:check_accessor_par
TEST.NEW
TEST.NAME:check_accessor_par.001_sp_cfg_get_range_begin()_MIN__sp_cfg_get_range_end()_MIN
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MIN, sp_cfg_get_range_begin() returns MIN, sp_cfg_get_range_end() returns MIN, 
pool_memory[sig_pool_1].values[0].signal_id is MIN: ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_id:<<MIN>>
TEST.VALUE:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.VALUE:signal_pool.check_accessor_par.sig_nr:<<MIN>>
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_begin.return:<<MIN>>
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_end.return:<<MIN>>
TEST.EXPECTED:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_begin.range:sp_hwver_input
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_end.range:sp_hwver_input
TEST.FLOW
  signal_pool.c.check_accessor_par
  uut_prototype_stubs.sp_cfg_get_range_begin
  uut_prototype_stubs.sp_cfg_get_range_end
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: check_accessor_par.002_sp_cfg_get_range_begin()_MID__sp_cfg_get_range_end()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:check_accessor_par
TEST.NEW
TEST.NAME:check_accessor_par.002_sp_cfg_get_range_begin()_MID__sp_cfg_get_range_end()_MID
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 50, sp_cfg_get_range_begin() returns 20, sp_cfg_get_range_end() returns 60, 
pool_memory[sig_pool_2].values[50].signal_id is 50: ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[50].signal_id:50
TEST.VALUE:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.VALUE:signal_pool.check_accessor_par.sig_nr:50
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_begin.return:20
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_end.return:60
TEST.EXPECTED:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_begin.range:sp_complete_pool
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_end.range:sp_complete_pool
TEST.FLOW
  signal_pool.c.check_accessor_par
  uut_prototype_stubs.sp_cfg_get_range_begin
  uut_prototype_stubs.sp_cfg_get_range_end
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: check_accessor_par.003_pool_memory[].values[].signal_id_MAX__ERR_SP_SIG_INVALID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:check_accessor_par
TEST.NEW
TEST.NAME:check_accessor_par.003_pool_memory[].values[].signal_id_MAX__ERR_SP_SIG_INVALID
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 50, sp_cfg_get_range_begin() returns 20, sp_cfg_get_range_end() returns 60, 
pool_memory[sig_pool_2].values[50].signal_id is MAX: ERR_SP_SIG_INVALID is returned.
TEST.END_NOTES:
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[50].signal_id:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.VALUE:signal_pool.check_accessor_par.sig_nr:50
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_begin.return:20
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_end.return:60
TEST.EXPECTED:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SIG_INVALID
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_begin.range:sp_complete_pool
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_end.range:sp_complete_pool
TEST.FLOW
  signal_pool.c.check_accessor_par
  uut_prototype_stubs.sp_cfg_get_range_begin
  uut_prototype_stubs.sp_cfg_get_range_end
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: check_accessor_par.004_sp_cfg_get_range_begin()_MAX__sp_cfg_get_range_end()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:check_accessor_par
TEST.NEW
TEST.NAME:check_accessor_par.004_sp_cfg_get_range_begin()_MAX__sp_cfg_get_range_end()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 50, sp_cfg_get_range_begin() returns MAX, 
sp_cfg_get_range_end() returns MAX: ERR_SP_SIG_OUT_OF_RANGE is returned.
TEST.END_NOTES:
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[50].signal_id:50
TEST.VALUE:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.VALUE:signal_pool.check_accessor_par.sig_nr:50
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_begin.return:4294967295
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_end.return:4294967295
TEST.EXPECTED:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SIG_OUT_OF_RANGE
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_begin.range:sp_complete_pool
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_end.range:sp_complete_pool
TEST.FLOW
  signal_pool.c.check_accessor_par
  uut_prototype_stubs.sp_cfg_get_range_begin
  uut_prototype_stubs.sp_cfg_get_range_end
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: check_accessor_par.005_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:check_accessor_par
TEST.NEW
TEST.NAME:check_accessor_par.005_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MAX, sp_cfg_get_range_begin() returns MIN, sp_cfg_get_range_end() returns MAX: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 140.
TEST.END_NOTES:
TEST.VALUE:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.VALUE:signal_pool.check_accessor_par.sig_nr:<<MAX>>
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_begin.return:<<MIN>>
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_end.return:4294967295
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_begin.range:sp_hwver_input
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_end.range:sp_hwver_input
TEST.FLOW
  signal_pool.c.check_accessor_par
  uut_prototype_stubs.sp_cfg_get_range_begin
  uut_prototype_stubs.sp_cfg_get_range_end
TEST.END_FLOW
TEST.END

-- Test Case: check_accessor_par.006_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:check_accessor_par
TEST.NEW
TEST.NAME:check_accessor_par.006_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, range is sp_hwver_input, sig_nr is 5, sp_cfg_get_range_begin() returns MIN, sp_cfg_get_range_end() returns MAX: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool].values[] gets outs of bounds at line 140.
TEST.END_NOTES:
TEST.VALUE:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.VALUE:signal_pool.check_accessor_par.sig_nr:5
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_begin.return:<<MIN>>
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_end.return:4294967295
TEST.EXPECTED:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_begin.range:sp_hwver_input
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_end.range:sp_hwver_input
TEST.FLOW
  signal_pool.c.check_accessor_par
  uut_prototype_stubs.sp_cfg_get_range_begin
  uut_prototype_stubs.sp_cfg_get_range_end
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Subprogram: get_signal_float

-- Test Case: get_signal_float.001_.val_float_MIN
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.001_.val_float_MIN
TEST.NOTES:
sig_pool is sig_pool_1, sig_nr is MIN, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is ffp32, pool_memory[sig_pool_1].values[0].z.val_float is MIN: 
value is set to -3.40282e+38, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].z.val_float:<<MIN>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.get_signal_float.range:sp_hwver_input
TEST.VALUE:signal_pool.get_signal_float.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.get_signal_float.value[0]:-3.40282E+38
TEST.EXPECTED:signal_pool.get_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.002_.val_float_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.002_.val_float_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is ffp32, pool_memory[sig_pool_2].values[30].z.val_float is 50: 
value is set to 50, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:50.0
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_float.range:sp_hwver_output
TEST.VALUE:signal_pool.get_signal_float.sig_nr:30
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:<<MIN>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_output
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_float.value[0]:50.0
TEST.EXPECTED:signal_pool.get_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.003_.val_float_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.003_.val_float_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is ffp32, pool_memory[sig_pool_2].values[30].z.val_float is MAX: 
value is set to 3.40282E+38, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_float.sig_nr:30
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:40.0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_float.value[0]:3.40282E+38
TEST.EXPECTED:signal_pool.get_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.004_.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.004_.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_float.sig_nr:30
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:40.0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_float.value[0]:40.0
TEST.EXPECTED:signal_pool.get_signal_float.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.005_check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.005_check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns 50: 50 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:50
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_float.sig_nr:30
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:40.0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_float.value[0]:40.0
TEST.EXPECTED:signal_pool.get_signal_float.return:50
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.006_check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.006_check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_float.sig_nr:30
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:40.0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_float.value[0]:40.0
TEST.EXPECTED:signal_pool.get_signal_float.return:4294967295
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.007_value_NULL
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.007_value_NULL
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is NULL: ERR_SP_GENERIC_ERROR is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:<<MAX>>
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_float.sig_nr:30
TEST.VALUE:signal_pool.get_signal_float.value:<<null>>
TEST.EXPECTED:signal_pool.get_signal_float.value:<<null>>
TEST.EXPECTED:signal_pool.get_signal_float.return:MACRO=ERR_SP_GENERIC_ERROR
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.008_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.008_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is MAX, value is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 213.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_float.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:40.0
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_float.009_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_float
TEST.NEW
TEST.NAME:get_signal_float.009_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, sig_nr is MIN, value is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 213.

TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_float.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.get_signal_float.range:sp_hwver_input
TEST.VALUE:signal_pool.get_signal_float.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.get_signal_float.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_float.value[0]:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.get_signal_float.value[0]:3.40282E+38
TEST.EXPECTED:signal_pool.get_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.get_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_float
TEST.END_FLOW
TEST.END

-- Subprogram: get_signal_uint32

-- Test Case: get_signal_uint32.001_.val_uint32_MIN
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.001_.val_uint32_MIN
TEST.NOTES:
sig_pool is sig_pool_1, sig_nr is MIN, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is uint32, pool_memory[sig_pool_1].values[0].z.val_uint32 is MIN: 
value is set to 0, ERR_SP_SUCCESS is returned.








TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].z.val_uint32:<<MIN>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_hwver_input
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.get_signal_uint32.value[0]:0
TEST.EXPECTED:signal_pool.get_signal_uint32.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.002_.val_uint32_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.002_.val_uint32_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is uint32, pool_memory[sig_pool_2].values[30].z.val_uint32 is 50: 
value is set to 50, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:50
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_hwver_output
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:<<MIN>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_output
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_uint32.value[0]:50
TEST.EXPECTED:signal_pool.get_signal_uint32.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.003_.val_uint32_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.003_.val_uint32_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is uint32, pool_memory[sig_pool_2].values[30].z.val_uint32 is MAX: 
value is set to 4294967295, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_uint32.value[0]:4294967295
TEST.EXPECTED:signal_pool.get_signal_uint32.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.004_.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.004_.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.get_signal_uint32.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.005_check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.005_check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns 50: 50 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:50
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.get_signal_uint32.return:50
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.006_check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.006_check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is valid, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.get_signal_uint32.return:4294967295
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.007_value_NULL
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.007_value_NULL
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is NULL: ERR_SP_GENERIC_ERROR is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:<<MAX>>
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.get_signal_uint32.value:<<null>>
TEST.EXPECTED:signal_pool.get_signal_uint32.value:<<null>>
TEST.EXPECTED:signal_pool.get_signal_uint32.return:MACRO=ERR_SP_GENERIC_ERROR
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.008_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.008_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is MAX, value is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 372.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:40
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: get_signal_uint32.009_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:get_signal_uint32
TEST.NEW
TEST.NAME:get_signal_uint32.009_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, sig_nr is MIN, value is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 372.






TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].z.val_uint32:<<MIN>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.get_signal_uint32.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.get_signal_uint32.range:sp_hwver_input
TEST.VALUE:signal_pool.get_signal_uint32.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.get_signal_uint32.value:<<malloc 1>>
TEST.VALUE:signal_pool.get_signal_uint32.value[0]:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.get_signal_uint32.value[0]:0
TEST.EXPECTED:signal_pool.get_signal_uint32.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.get_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.get_signal_uint32
TEST.END_FLOW
TEST.END

-- Subprogram: init_pool_memory

-- Test Case: init_pool_memory.001_sig_pool_1__sp_cfg_get_range_size()_MIN_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:init_pool_memory
TEST.NEW
TEST.NAME:init_pool_memory.001_sig_pool_1__sp_cfg_get_range_size()_MIN_MID
TEST.NOTES:
sig_pool is sig_pool_1, sp_cfg_get_range_size() returns MIN at 1st call and 10 at all other calls: 
pool_memory[sig_pool_1].values[0-132].signal_type and pool_memory[sig_pool_1].values[0-132].signal_id are set,
configs[0-46].start, configs[0-45].size and configs[0-45].end are set, TRUE is returned.
TEST.END_NOTES:
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_id:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_id:50
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:ffp64
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].size:40
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].start:50
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].end:60
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].size:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].start:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].end:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].size:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].start:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].end:<<MIN>>
TEST.VALUE:signal_pool.init_pool_memory.sig_pool:sig_pool_1
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_size.return:<<MIN>>,10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_id:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_id:1
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_id:2
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_id:3
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_id:4
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_id:5
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_id:6
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_id:7
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_id:8
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_id:9
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_id:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_id:11
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_id:12
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_id:13
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_id:14
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_id:15
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_id:16
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_id:17
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_id:18
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_id:19
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_id:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_id:21
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_id:22
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_id:23
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_id:24
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_id:25
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_id:26
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_id:27
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_id:28
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_id:29
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_id:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_id:31
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_id:32
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_id:33
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_id:34
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_id:35
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_id:36
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_id:37
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_id:38
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_id:39
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_id:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_id:41
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_id:42
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_id:43
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_id:44
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_id:45
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_id:46
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_id:47
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_id:48
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_id:49
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_id:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_id:51
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_id:52
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_id:53
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_id:54
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_id:55
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_id:56
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_id:57
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_id:58
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_id:59
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_id:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_id:61
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_id:62
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_id:63
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_id:64
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_id:65
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_id:66
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_id:67
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_id:68
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_id:69
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_id:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_id:71
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_id:72
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_id:73
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_id:74
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_id:75
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_id:76
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_id:77
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_id:78
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_id:79
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_id:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_id:81
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_id:82
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_id:83
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_id:84
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_id:85
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_id:86
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_id:87
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_id:88
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_id:89
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_id:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_id:91
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_id:92
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_id:93
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_id:94
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_id:95
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_id:96
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_id:97
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_id:98
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_id:99
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_id:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_id:101
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_id:102
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_id:103
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_id:104
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_id:105
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_id:106
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_id:107
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_id:108
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_id:109
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_id:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_id:111
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_id:112
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_id:113
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_id:114
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_id:115
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_id:116
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_id:117
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_id:118
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_id:119
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_id:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_id:121
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_id:122
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_id:123
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_id:124
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_id:125
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_id:126
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_id:127
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_id:128
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_id:129
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_id:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_id:131
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_id:132
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].size:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].end:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].end:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].start:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].end:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].start:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].end:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].start:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].end:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].start:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].end:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].start:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].end:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].start:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].end:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].start:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].end:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].start:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].end:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].start:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].end:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].start:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].end:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].start:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].end:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].start:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].end:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].start:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].end:140
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].start:140
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].end:150
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].start:150
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].end:160
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].start:160
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].end:170
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].start:170
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].end:180
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].start:180
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].end:190
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].start:190
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].end:200
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].start:200
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].end:210
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].start:210
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].end:220
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].start:220
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].end:230
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].start:230
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].end:240
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].start:240
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].end:250
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].start:250
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].end:260
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].start:260
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].end:270
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].start:270
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].end:280
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].start:280
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].end:290
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].start:290
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].end:300
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].start:300
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].end:310
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].start:310
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].end:320
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].start:320
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].end:330
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].start:330
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].end:340
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].start:340
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].end:350
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].start:350
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].end:360
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].start:360
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].end:370
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].start:370
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].end:380
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].start:380
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].end:390
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].start:390
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].end:400
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].start:400
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].end:410
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].start:410
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].end:420
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].start:420
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].end:430
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].start:430
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].end:440
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].start:440
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].end:450
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].size:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].end:0
TEST.EXPECTED:signal_pool.init_pool_memory.return:true
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_size.range:sp_hwver_input,sp_temp_input,sp_v_sbc_0_input,sp_v_sbc_1_input,sp_v_sbc_2_input,sp_v_sbc_3_input,sp_v_test_0_input,sp_v_test_1v5_input,sp_ai_b1_no_input,sp_ai_b1_nc_input,sp_ai_b2_no_input,sp_ai_b2_nc_input,sp_ai_b3_no_input,sp_ai_b3_nc_input,sp_ai_b4_no_input,sp_ai_b4_nc_input,sp_ai_b5f_no_input,sp_ai_b5f_nc_input,sp_ai_b5r_no_input,sp_ai_b5r_nc_input,sp_ai_tw_6a_input,sp_ai_tw_6b_input,sp_ai_tw_8a_input,sp_ai_tw_8b_input,sp_2dh0_1_input,sp_2dh1_1_input,sp_2dh0_2_input,sp_2dh1_2_input,sp_hwver_output,sp_temp_output,sp_v_sbc_0_output,sp_v_sbc_1_output,sp_v_sbc_2_output,sp_v_sbc_3_output,sp_v_test_0_output,sp_v_test_1v5_output,sp_ai_b1_output,sp_ai_b2_output,sp_ai_b3_output,sp_ai_b4_output,sp_ai_b5f_output,sp_ai_b5r_output,sp_ai_tw_6_output,sp_ai_tw_8_output,sp_2dh0_output,sp_2dh1_output
TEST.FLOW
  signal_pool.c.init_pool_memory
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  signal_pool.c.init_pool_memory
TEST.END_FLOW
TEST.END

-- Test Case: init_pool_memory.002_sig_pool_1__sp_cfg_get_range_size()_MAX_overflow
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:init_pool_memory
TEST.NEW
TEST.NAME:init_pool_memory.002_sig_pool_1__sp_cfg_get_range_size()_MAX_overflow
TEST.NOTES:
sig_pool is sig_pool_1, sp_cfg_get_range_size() returns MIN at 1st call, MAX at last call and 10 at all other calls: overflow is occurred.

/***/
In case (offset + configs[i].size) results to a number greater than 4294967295, overflow occurs at line 78.
TEST.END_NOTES:
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_id:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_id:50
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:ffp64
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_id:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].size:40
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].start:50
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].end:60
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].size:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].start:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].end:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].size:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].start:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].end:<<MIN>>
TEST.VALUE:signal_pool.init_pool_memory.sig_pool:sig_pool_1
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_size.return:<<MIN>>,(44)10,4294967295
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_id:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_id:1
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_id:2
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_id:3
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[4].signal_id:4
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[5].signal_id:5
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[6].signal_id:6
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[7].signal_id:7
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[8].signal_id:8
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[9].signal_id:9
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[10].signal_id:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[11].signal_id:11
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[12].signal_id:12
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[13].signal_id:13
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[14].signal_id:14
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[15].signal_id:15
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[16].signal_id:16
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[17].signal_id:17
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[18].signal_id:18
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[19].signal_id:19
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[20].signal_id:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[21].signal_id:21
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[22].signal_id:22
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[23].signal_id:23
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[24].signal_id:24
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[25].signal_id:25
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[26].signal_id:26
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[27].signal_id:27
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[28].signal_id:28
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[29].signal_id:29
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[30].signal_id:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[31].signal_id:31
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[32].signal_id:32
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[33].signal_id:33
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[34].signal_id:34
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[35].signal_id:35
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[36].signal_id:36
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[37].signal_id:37
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[38].signal_id:38
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[39].signal_id:39
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[40].signal_id:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[41].signal_id:41
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[42].signal_id:42
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[43].signal_id:43
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[44].signal_id:44
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[45].signal_id:45
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[46].signal_id:46
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[47].signal_id:47
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[48].signal_id:48
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[49].signal_id:49
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[50].signal_id:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[51].signal_id:51
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[52].signal_id:52
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[53].signal_id:53
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[54].signal_id:54
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[55].signal_id:55
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[56].signal_id:56
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[57].signal_id:57
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[58].signal_id:58
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[59].signal_id:59
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[60].signal_id:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[61].signal_id:61
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[62].signal_id:62
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[63].signal_id:63
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[64].signal_id:64
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[65].signal_id:65
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[66].signal_id:66
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[67].signal_id:67
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[68].signal_id:68
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[69].signal_id:69
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[70].signal_id:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[71].signal_id:71
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[72].signal_id:72
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[73].signal_id:73
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[74].signal_id:74
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[75].signal_id:75
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[76].signal_id:76
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[77].signal_id:77
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[78].signal_id:78
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[79].signal_id:79
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[80].signal_id:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[81].signal_id:81
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[82].signal_id:82
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[83].signal_id:83
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[84].signal_id:84
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[85].signal_id:85
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[86].signal_id:86
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[87].signal_id:87
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[88].signal_id:88
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[89].signal_id:89
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[90].signal_id:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[91].signal_id:91
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[92].signal_id:92
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[93].signal_id:93
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[94].signal_id:94
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[95].signal_id:95
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[96].signal_id:96
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[97].signal_id:97
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[98].signal_id:98
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[99].signal_id:99
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[100].signal_id:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[101].signal_id:101
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[102].signal_id:102
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[103].signal_id:103
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[104].signal_id:104
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[105].signal_id:105
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[106].signal_id:106
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[107].signal_id:107
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[108].signal_id:108
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[109].signal_id:109
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[110].signal_id:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[111].signal_id:111
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[112].signal_id:112
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[113].signal_id:113
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[114].signal_id:114
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[115].signal_id:115
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[116].signal_id:116
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[117].signal_id:117
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[118].signal_id:118
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[119].signal_id:119
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[120].signal_id:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[121].signal_id:121
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[122].signal_id:122
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[123].signal_id:123
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[124].signal_id:124
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[125].signal_id:125
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[126].signal_id:126
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[127].signal_id:127
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[128].signal_id:128
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[129].signal_id:129
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[130].signal_id:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[131].signal_id:131
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_type:invalid
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[132].signal_id:132
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].size:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].end:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].end:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].start:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].end:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].start:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].end:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].start:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].end:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].start:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].end:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].start:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].end:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].start:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].end:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].start:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].end:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].start:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].end:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].start:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].end:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].start:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].end:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].start:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].end:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].start:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].end:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].start:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].end:140
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].start:140
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].end:150
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].start:150
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].end:160
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].start:160
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].end:170
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].start:170
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].end:180
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].start:180
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].end:190
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].start:190
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].end:200
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].start:200
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].end:210
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].start:210
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].end:220
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].start:220
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].end:230
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].start:230
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].end:240
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].start:240
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].end:250
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].start:250
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].end:260
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].start:260
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].end:270
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].start:270
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].end:280
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].start:280
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].end:290
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].start:290
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].end:300
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].start:300
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].end:310
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].start:310
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].end:320
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].start:320
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].end:330
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].start:330
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].end:340
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].start:340
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].end:350
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].start:350
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].end:360
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].start:360
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].end:370
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].start:370
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].end:380
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].start:380
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].end:390
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].start:390
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].end:400
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].start:400
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].end:410
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].start:410
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].end:420
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].start:420
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].end:430
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].start:430
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].end:440
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].size:4294967295
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].start:440
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].end:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].size:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].end:0
TEST.EXPECTED:signal_pool.init_pool_memory.return:true
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_size.range:sp_hwver_input,sp_temp_input,sp_v_sbc_0_input,sp_v_sbc_1_input,sp_v_sbc_2_input,sp_v_sbc_3_input,sp_v_test_0_input,sp_v_test_1v5_input,sp_ai_b1_no_input,sp_ai_b1_nc_input,sp_ai_b2_no_input,sp_ai_b2_nc_input,sp_ai_b3_no_input,sp_ai_b3_nc_input,sp_ai_b4_no_input,sp_ai_b4_nc_input,sp_ai_b5f_no_input,sp_ai_b5f_nc_input,sp_ai_b5r_no_input,sp_ai_b5r_nc_input,sp_ai_tw_6a_input,sp_ai_tw_6b_input,sp_ai_tw_8a_input,sp_ai_tw_8b_input,sp_2dh0_1_input,sp_2dh1_1_input,sp_2dh0_2_input,sp_2dh1_2_input,sp_hwver_output,sp_temp_output,sp_v_sbc_0_output,sp_v_sbc_1_output,sp_v_sbc_2_output,sp_v_sbc_3_output,sp_v_test_0_output,sp_v_test_1v5_output,sp_ai_b1_output,sp_ai_b2_output,sp_ai_b3_output,sp_ai_b4_output,sp_ai_b5f_output,sp_ai_b5r_output,sp_ai_tw_6_output,sp_ai_tw_8_output,sp_2dh0_output,sp_2dh1_output
TEST.FLOW
  signal_pool.c.init_pool_memory
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  signal_pool.c.init_pool_memory
TEST.END_FLOW
TEST.END

-- Test Case: init_pool_memory.003_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:init_pool_memory
TEST.NEW
TEST.NAME:init_pool_memory.003_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, sp_cfg_get_range_size() returns MIN at 1st call and 10 at all other calls: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 68.


TEST.END_NOTES:
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[0].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].size:40
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].start:50
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[1].end:60
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].size:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].start:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[2].end:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[3].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[4].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[5].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[6].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[7].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[8].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[9].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[10].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[11].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[12].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[13].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[14].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[15].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[16].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[17].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[18].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[19].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[20].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[21].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[22].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[23].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[24].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[25].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[26].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[27].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[28].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[29].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[30].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[31].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[32].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[33].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[34].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[35].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[36].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[37].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[38].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[39].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[40].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[41].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[42].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[43].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[44].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].size:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].start:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[45].end:<<MAX>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].size:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].start:<<MIN>>
TEST.VALUE:signal_pool.<<GLOBAL>>.configs[46].end:<<MIN>>
TEST.VALUE:signal_pool.init_pool_memory.sig_pool:sig_nr_max
TEST.VALUE:uut_prototype_stubs.sp_cfg_get_range_size.return:<<MIN>>,10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].size:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[0].end:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[1].end:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].start:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[2].end:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].start:20
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[3].end:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].start:30
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[4].end:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].start:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[5].end:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].start:50
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[6].end:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].start:60
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[7].end:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].start:70
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[8].end:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].start:80
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[9].end:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].start:90
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[10].end:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].start:100
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[11].end:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].start:110
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[12].end:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].start:120
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[13].end:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].start:130
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[14].end:140
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].start:140
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[15].end:150
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].start:150
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[16].end:160
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].start:160
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[17].end:170
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].start:170
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[18].end:180
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].start:180
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[19].end:190
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].start:190
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[20].end:200
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].start:200
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[21].end:210
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].start:210
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[22].end:220
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].start:220
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[23].end:230
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].start:230
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[24].end:240
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].start:240
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[25].end:250
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].start:250
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[26].end:260
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].start:260
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[27].end:270
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].start:270
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[28].end:280
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].start:280
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[29].end:290
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].start:290
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[30].end:300
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].start:300
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[31].end:310
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].start:310
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[32].end:320
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].start:320
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[33].end:330
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].start:330
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[34].end:340
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].start:340
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[35].end:350
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].start:350
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[36].end:360
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].start:360
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[37].end:370
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].start:370
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[38].end:380
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].start:380
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[39].end:390
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].start:390
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[40].end:400
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].start:400
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[41].end:410
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].start:410
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[42].end:420
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].start:420
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[43].end:430
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].start:430
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[44].end:440
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].size:10
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].start:440
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[45].end:450
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].size:266287972355
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].start:0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.configs[46].end:3
TEST.EXPECTED:signal_pool.init_pool_memory.return:false
TEST.EXPECTED:uut_prototype_stubs.sp_cfg_get_range_size.range:sp_hwver_input,sp_temp_input,sp_v_sbc_0_input,sp_v_sbc_1_input,sp_v_sbc_2_input,sp_v_sbc_3_input,sp_v_test_0_input,sp_v_test_1v5_input,sp_ai_b1_no_input,sp_ai_b1_nc_input,sp_ai_b2_no_input,sp_ai_b2_nc_input,sp_ai_b3_no_input,sp_ai_b3_nc_input,sp_ai_b4_no_input,sp_ai_b4_nc_input,sp_ai_b5f_no_input,sp_ai_b5f_nc_input,sp_ai_b5r_no_input,sp_ai_b5r_nc_input,sp_ai_tw_6a_input,sp_ai_tw_6b_input,sp_ai_tw_8a_input,sp_ai_tw_8b_input,sp_2dh0_1_input,sp_2dh1_1_input,sp_2dh0_2_input,sp_2dh1_2_input,sp_hwver_output,sp_temp_output,sp_v_sbc_0_output,sp_v_sbc_1_output,sp_v_sbc_2_output,sp_v_sbc_3_output,sp_v_test_0_output,sp_v_test_1v5_output,sp_ai_b1_output,sp_ai_b2_output,sp_ai_b3_output,sp_ai_b4_output,sp_ai_b5f_output,sp_ai_b5r_output,sp_ai_tw_6_output,sp_ai_tw_8_output,sp_2dh0_output,sp_2dh1_output
TEST.FLOW
  signal_pool.c.init_pool_memory
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  uut_prototype_stubs.sp_cfg_get_range_size
  signal_pool.c.init_pool_memory
TEST.END_FLOW
TEST.END

-- Subprogram: map_raw_float_ro

-- Test Case: map_raw_float_ro.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is ffp32: *map_target is set to address of pool_memory[sig_pool_1].values[0].z.val_float,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:ffp32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_float_ro.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_ro
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_float_ro.map_target[0]
{{ <<signal_pool.map_raw_float_ro.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_1].values[0].z.val_float ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_float_ro.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_hwver_output, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is ffp32: *map_target is set to address of pool_memory[sig_pool_2].values[132].z.val_float,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:ffp32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_hwver_output
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_output
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_ro.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_ro
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_float_ro.map_target[0]
{{ <<signal_pool.map_raw_float_ro.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_2].values[132].z.val_float ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_float_ro.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:invalid
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_ro.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_ro
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_ro.004_sig_nr_MID__check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.004_sig_nr_MID__check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns 50: 50 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:50
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_ro.return:50
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_ro
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_ro.005_sig_nr_MID__check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.005_sig_nr_MID__check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<malloc 1>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_ro.return:4294967295
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_ro
TEST.END_FLOW
TEST.VALUE_USER_CODE:signal_pool.map_raw_float_ro.map_target[0]
<<signal_pool.map_raw_float_ro.map_target>>[0] = ( 0x45456754 );
TEST.END_VALUE_USER_CODE:
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_float_ro.map_target[0]
{{ <<signal_pool.map_raw_float_ro.map_target>>[0] == ( 0x45456754 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_float_ro.006_sig_nr_MID__map_target_NULL
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.006_sig_nr_MID__map_target_NULL
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is NULL: ERR_SP_GENERIC_ERROR is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_ro.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_ro.return:MACRO=ERR_SP_GENERIC_ERROR
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.map_raw_float_ro
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_ro.007_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.007_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MAX, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 301.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_ro.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_ro
TEST.NEW
TEST.NAME:map_raw_float_ro.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 301.

TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_ro.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.map_raw_float_ro.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_float_ro.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_float_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_ro.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_float_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_ro
TEST.END_FLOW
TEST.END

-- Subprogram: map_raw_float_rw

-- Test Case: map_raw_float_rw.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is ffp32: *map_target is set to address of pool_memory[sig_pool_1].values[0].z.val_float,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:ffp32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_float_rw.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_rw
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_float_rw.map_target[0]
{{ <<signal_pool.map_raw_float_rw.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_1].values[0].z.val_float ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_float_rw.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_ffp32
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_hwver_output, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is ffp32: *map_target is set to address of pool_memory[sig_pool_2].values[132].z.val_float,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:ffp32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_hwver_output
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_output
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_rw.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_rw
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_float_rw.map_target[0]
{{ <<signal_pool.map_raw_float_rw.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_2].values[132].z.val_float ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_float_rw.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:invalid
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_rw.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_rw
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_rw.004_sig_nr_MID__check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.004_sig_nr_MID__check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns 50: 50 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:50
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_rw.return:50
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_rw
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_rw.005_sig_nr_MID__check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.005_sig_nr_MID__check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<malloc 1>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_float_rw.return:4294967295
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_rw
TEST.END_FLOW
TEST.VALUE_USER_CODE:signal_pool.map_raw_float_rw.map_target[0]
<<signal_pool.map_raw_float_rw.map_target>>[0] = ( 0x45456754 );
TEST.END_VALUE_USER_CODE:
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_float_rw.map_target[0]
{{ <<signal_pool.map_raw_float_rw.map_target>>[0] == ( 0x45456754 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_float_rw.006_sig_nr_MID__map_target_NULL
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.006_sig_nr_MID__map_target_NULL
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is NULL: ERR_SP_GENERIC_ERROR is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_rw.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_rw.return:MACRO=ERR_SP_GENERIC_ERROR
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.map_raw_float_rw
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_rw.007_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.007_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MAX, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 257.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_float_rw.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_float_rw
TEST.NEW
TEST.NAME:map_raw_float_rw.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 257.

TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_float_rw.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.map_raw_float_rw.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_float_rw.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_float_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_float_rw.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_float_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_float_rw
TEST.END_FLOW
TEST.END

-- Subprogram: map_raw_uint32_ro

-- Test Case: map_raw_uint32_ro.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is uint32: *map_target is set to address of pool_memory[sig_pool_1].values[0].z.val_uint32,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_ro
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_uint32_ro.map_target[0]
{{ <<signal_pool.map_raw_uint32_ro.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_1].values[0].z.val_uint32 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_uint32_ro.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_hwver_output, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is uint32: *map_target is set to address of pool_memory[sig_pool_2].values[132].z.val_uint32,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:uint32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_hwver_output
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_output
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_ro
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_uint32_ro.map_target[0]
{{ <<signal_pool.map_raw_uint32_ro.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_2].values[132].z.val_uint32 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_uint32_ro.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:invalid
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_ro
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_ro.004_sig_nr_MID__check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.004_sig_nr_MID__check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns 50: 50 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:50
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.return:50
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_ro
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_ro.005_sig_nr_MID__check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.005_sig_nr_MID__check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<malloc 1>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.return:4294967295
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_ro
TEST.END_FLOW
TEST.VALUE_USER_CODE:signal_pool.map_raw_uint32_ro.map_target[0]
<<signal_pool.map_raw_uint32_ro.map_target>>[0] = ( 0x45456754 );
TEST.END_VALUE_USER_CODE:
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_uint32_ro.map_target[0]
{{ <<signal_pool.map_raw_uint32_ro.map_target>>[0] == ( 0x45456754 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_uint32_ro.006_sig_nr_MID__map_target_NULL
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.006_sig_nr_MID__map_target_NULL
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is NULL: ERR_SP_GENERIC_ERROR is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.return:MACRO=ERR_SP_GENERIC_ERROR
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.map_raw_uint32_ro
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_ro.007_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.007_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MAX, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 460.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_ro.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_ro
TEST.NEW
TEST.NAME:map_raw_uint32_ro.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 460.

TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.map_raw_uint32_ro.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_uint32_ro.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_ro.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_uint32_ro
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_ro
TEST.END_FLOW
TEST.END

-- Subprogram: map_raw_uint32_rw

-- Test Case: map_raw_uint32_rw.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.001_sig_nr_MIN__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is uint32: *map_target is set to address of pool_memory[sig_pool_1].values[0].z.val_uint32,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_rw
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_uint32_rw.map_target[0]
{{ <<signal_pool.map_raw_uint32_rw.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_1].values[0].z.val_uint32 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_uint32_rw.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.002_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_uint32
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_hwver_output, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is uint32: *map_target is set to address of pool_memory[sig_pool_2].values[132].z.val_uint32,
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:uint32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_hwver_output
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_output
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_rw
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_uint32_rw.map_target[0]
{{ <<signal_pool.map_raw_uint32_rw.map_target>>[0] == ( &<<signal_pool.<<GLOBAL>>.pool_memory>>[sig_pool_2].values[132].z.val_uint32 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_uint32_rw.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.003_sig_nr_MID__check_accessor_par()_ERR_SP_SUCCESS__.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS,
pool_memory[sig_pool_2].values[132].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[132].signal_type:invalid
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_rw
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_rw.004_sig_nr_MID__check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.004_sig_nr_MID__check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns 50: 50 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:50
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.return:50
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_rw
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_rw.005_sig_nr_MID__check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.005_sig_nr_MID__check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is valid, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<malloc 1>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:132
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.return:4294967295
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_rw
TEST.END_FLOW
TEST.VALUE_USER_CODE:signal_pool.map_raw_uint32_rw.map_target[0]
<<signal_pool.map_raw_uint32_rw.map_target>>[0] = ( 0x45456754 );
TEST.END_VALUE_USER_CODE:
TEST.EXPECTED_USER_CODE:signal_pool.map_raw_uint32_rw.map_target[0]
{{ <<signal_pool.map_raw_uint32_rw.map_target>>[0] == ( 0x45456754 ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: map_raw_uint32_rw.006_sig_nr_MID__map_target_NULL
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.006_sig_nr_MID__map_target_NULL
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, sig_nr is 132, map_target is NULL: ERR_SP_GENERIC_ERROR is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_complete_pool
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:132
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.map_target:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.return:MACRO=ERR_SP_GENERIC_ERROR
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.map_raw_uint32_rw
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_rw.007_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.007_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, sig_nr is MAX, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 416.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: map_raw_uint32_rw.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:map_raw_uint32_rw
TEST.NEW
TEST.NAME:map_raw_uint32_rw.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, range is sp_hwver_input, sig_nr is MIN, map_target is valid, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 416.

TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.map_raw_uint32_rw.range:sp_hwver_input
TEST.VALUE:signal_pool.map_raw_uint32_rw.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target:<<malloc 1>>
TEST.VALUE:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.map_target[0]:<<null>>
TEST.EXPECTED:signal_pool.map_raw_uint32_rw.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.map_raw_uint32_rw
  signal_pool.c.check_accessor_par
  signal_pool.c.map_raw_uint32_rw
TEST.END_FLOW
TEST.END

-- Subprogram: set_signal_float

-- Test Case: set_signal_float.001_value_MIN
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.001_value_MIN
TEST.NOTES:
sig_pool is sig_pool_1, sig_nr is MIN, value is MIN, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is ffp32: pool_memory[sig_pool_1].values[0].z.val_float is set to -3.40282E+38, 
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].z.val_float:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.set_signal_float.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_float.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.set_signal_float.value:<<MIN>>
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].z.val_float:-3.40282E+38
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.set_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_float.002_value_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.002_value_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is 50, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is ffp32: pool_memory[sig_pool_2].values[30].z.val_float is set to 50, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:<<MIN>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_float.range:sp_hwver_output
TEST.VALUE:signal_pool.set_signal_float.sig_nr:30
TEST.VALUE:signal_pool.set_signal_float.value:50.0
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:50.0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_output
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_float.003_value_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.003_value_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is ffp32: pool_memory[sig_pool_2].values[30].z.val_float is set to 3.40282E+38, 
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:ffp32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:10.0
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_float.sig_nr:30
TEST.VALUE:signal_pool.set_signal_float.value:<<MAX>>
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:3.40282E+38
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_float.004_.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.004_.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:10.0
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_float.sig_nr:30
TEST.VALUE:signal_pool.set_signal_float.value:<<MAX>>
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_float:10.0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_float.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_float.005_check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.005_check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns 40: 40 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:40
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_float.sig_nr:30
TEST.VALUE:signal_pool.set_signal_float.value:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_float.return:40
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_float.006_check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.006_check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_float.sig_nr:30
TEST.VALUE:signal_pool.set_signal_float.value:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_float.return:4294967295
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_float
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_float.007_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.007_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is MAX, value is MAX, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 338.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_float.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_float.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.set_signal_float.value:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_float.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_float
TEST.NEW
TEST.NAME:set_signal_float.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, sig_nr is MIN, value is MIN, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 338.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_float.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.set_signal_float.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_float.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.set_signal_float.value:<<MIN>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.set_signal_float.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_float
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_float
TEST.END_FLOW
TEST.END

-- Subprogram: set_signal_type

-- Test Case: set_signal_type.001_pool_memory[].values[].signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_type
TEST.NEW
TEST.NAME:set_signal_type.001_pool_memory[].values[].signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, begin_range is MIN, end_range is 4, type is uint32, check_accessor_par() returns ERR_SP_SUCCESS at both calls,
pool_memory[sig_pool_1].values[0-3].signal_type are invalid: pool_memory[sig_pool_1].values[0-3].signal_type are set to uint32, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:invalid
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_type.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.set_signal_type.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_type.begin_range:<<MIN>>
TEST.VALUE:signal_pool.set_signal_type.end_range:4
TEST.VALUE:signal_pool.set_signal_type.type:uint32
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:uint32
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:uint32
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:uint32
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0,4
TEST.EXPECTED:signal_pool.set_signal_type.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_type
  signal_pool.c.check_accessor_par
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_type
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_type.002_pool_memory[].values[].signal_type_uint32
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_type
TEST.NEW
TEST.NAME:set_signal_type.002_pool_memory[].values[].signal_type_uint32
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_v_test_0_input, begin_range is MIN, end_range is 4, type is ffp64, check_accessor_par() returns ERR_SP_SUCCESS at both calls,
pool_memory[sig_pool_1].values[0-2].signal_type are invalid, pool_memory[sig_pool_1].values[3].signal_type is uint32: 
pool_memory[sig_pool_1].values[0-2].signal_type are set to ffp64, ERR_SP_GENERIC_ERROR is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:uint32
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_type.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.set_signal_type.range:sp_v_test_0_input
TEST.VALUE:signal_pool.set_signal_type.begin_range:<<MIN>>
TEST.VALUE:signal_pool.set_signal_type.end_range:4
TEST.VALUE:signal_pool.set_signal_type.type:ffp64
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:ffp64
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[1].signal_type:ffp64
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[2].signal_type:ffp64
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[3].signal_type:uint32
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_v_test_0_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0,4
TEST.EXPECTED:signal_pool.set_signal_type.return:MACRO=ERR_SP_GENERIC_ERROR
TEST.FLOW
  signal_pool.c.set_signal_type
  signal_pool.c.check_accessor_par
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_type
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_type.003_begin_range_MAX__end_range_MIN
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_type
TEST.NEW
TEST.NAME:set_signal_type.003_begin_range_MAX__end_range_MIN
TEST.NOTES:
sig_pool is sig_pool_2, range is sp_complete_pool, begin_range is MAX, end_range is MIN, type is invalid, check_accessor_par() returns ERR_SP_SUCCESS at both calls:
ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_type.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_type.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_type.begin_range:<<MAX>>
TEST.VALUE:signal_pool.set_signal_type.end_range:<<MIN>>
TEST.VALUE:signal_pool.set_signal_type.type:invalid
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295,0
TEST.EXPECTED:signal_pool.set_signal_type.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_type
  signal_pool.c.check_accessor_par
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_type
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_type.004_check_accessor_par()_MID_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_type
TEST.NEW
TEST.NAME:set_signal_type.004_check_accessor_par()_MID_MAX
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, begin_range is MIN, end_range is 4, type is uint32, check_accessor_par() returns 40 at 1st call 
and MAX at 2nd call: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:40,<<MAX>>
TEST.VALUE:signal_pool.set_signal_type.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.set_signal_type.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_type.begin_range:<<MIN>>
TEST.VALUE:signal_pool.set_signal_type.end_range:4
TEST.VALUE:signal_pool.set_signal_type.type:uint32
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0,4
TEST.EXPECTED:signal_pool.set_signal_type.return:4294967295
TEST.FLOW
  signal_pool.c.set_signal_type
  signal_pool.c.check_accessor_par
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_type
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_type.005_end_range_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_type
TEST.NEW
TEST.NAME:set_signal_type.005_end_range_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_1, range is sp_hwver_input, begin_range is 4294967294, end_range is MAX, type is uint32, 
check_accessor_par() returns ERR_SP_SUCCESS at both calls: array out of bounds.

/***/
In case end_range is greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[i].signal_type gets out of bounds at line 176.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_type.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.set_signal_type.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_type.begin_range:4294967294
TEST.VALUE:signal_pool.set_signal_type.end_range:<<MAX>>
TEST.VALUE:signal_pool.set_signal_type.type:uint32
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967294,4294967295
TEST.FLOW
  signal_pool.c.set_signal_type
  signal_pool.c.check_accessor_par
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_type.006_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_type
TEST.NEW
TEST.NAME:set_signal_type.006_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, range is sp_hwver_input, begin_range is MIN, end_range is 4, type is uint32, 
check_accessor_par() returns ERR_SP_SUCCESS at both calls: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 176.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_type.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.set_signal_type.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_type.begin_range:<<MIN>>
TEST.VALUE:signal_pool.set_signal_type.end_range:4
TEST.VALUE:signal_pool.set_signal_type.type:uint32
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0,4
TEST.EXPECTED:signal_pool.set_signal_type.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_type
  signal_pool.c.check_accessor_par
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_type
TEST.END_FLOW
TEST.END

-- Subprogram: set_signal_uint32

-- Test Case: set_signal_uint32.001_value_MIN
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.001_value_MIN
TEST.NOTES:
sig_pool is sig_pool_1, sig_nr is MIN, value is MIN, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_1].values[0].signal_type is uint32: pool_memory[sig_pool_1].values[0].z.val_uint32 is set to 0, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].z.val_uint32:<<MAX>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_pool_1
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.set_signal_uint32.value:<<MIN>>
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_1].values[0].z.val_uint32:0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_1
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.set_signal_uint32.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_uint32.002_value_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.002_value_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is 40, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is uint32: pool_memory[sig_pool_2].values[30].z.val_uint32 is set to 40, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:<<MIN>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_2dh1_2_input
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.set_signal_uint32.value:40
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:40
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_2dh1_2_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_uint32.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_uint32.003_value_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.003_value_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is uint32: pool_memory[sig_pool_2].values[30].z.val_uint32 is set to 4294967295, ERR_SP_SUCCESS is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:uint32
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:50
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.set_signal_uint32.value:<<MAX>>
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:4294967295
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_uint32.return:MACRO=ERR_SP_SUCCESS
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_uint32.004_.signal_type_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.004_.signal_type_invalid
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns ERR_SP_SUCCESS, 
pool_memory[sig_pool_2].values[30].signal_type is invalid: ERR_SP_INVALID_DTYPE is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].signal_type:invalid
TEST.VALUE:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:<<MIN>>
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.set_signal_uint32.value:<<MAX>>
TEST.EXPECTED:signal_pool.<<GLOBAL>>.pool_memory[sig_pool_2].values[30].z.val_uint32:0
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_uint32.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_uint32.005_check_accessor_par()_MID
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.005_check_accessor_par()_MID
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns 40: 40 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:40
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.set_signal_uint32.value:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_uint32.return:40
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_uint32.006_check_accessor_par()_MAX
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.006_check_accessor_par()_MAX
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is 30, value is MAX, check_accessor_par() returns MAX: 4294967295 is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:<<MAX>>
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:30
TEST.VALUE:signal_pool.set_signal_uint32.value:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:30
TEST.EXPECTED:signal_pool.set_signal_uint32.return:4294967295
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_uint32
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_uint32.007_sig_nr_MAX_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.007_sig_nr_MAX_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_pool_2, sig_nr is MAX, value is MAX, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_nr is equal to or greater than SP_NR_OF_MEM_CELLS (133), array pool_memory[].values[sig_nr] gets out of bounds at line 496.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_complete_pool
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:<<MAX>>
TEST.VALUE:signal_pool.set_signal_uint32.value:<<MAX>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_pool_2
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_complete_pool
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:4294967295
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
TEST.END_FLOW
TEST.END

-- Test Case: set_signal_uint32.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:set_signal_uint32
TEST.NEW
TEST.NAME:set_signal_uint32.008_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, sig_nr is MIN, value is MIN, check_accessor_par() returns ERR_SP_SUCCESS: array out of bounds.

/***/
In case sig_pool is sig_nr_max, array pool_memory[sig_pool] gets out of bounds at line 496.
TEST.END_NOTES:
TEST.STUB:signal_pool.check_accessor_par
TEST.VALUE:signal_pool.check_accessor_par.return:MACRO=ERR_SP_SUCCESS
TEST.VALUE:signal_pool.set_signal_uint32.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.set_signal_uint32.range:sp_hwver_input
TEST.VALUE:signal_pool.set_signal_uint32.sig_nr:<<MIN>>
TEST.VALUE:signal_pool.set_signal_uint32.value:<<MIN>>
TEST.EXPECTED:signal_pool.check_accessor_par.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.check_accessor_par.range:sp_hwver_input
TEST.EXPECTED:signal_pool.check_accessor_par.sig_nr:0
TEST.EXPECTED:signal_pool.set_signal_uint32.return:MACRO=ERR_SP_INVALID_DTYPE
TEST.FLOW
  signal_pool.c.set_signal_uint32
  signal_pool.c.check_accessor_par
  signal_pool.c.set_signal_uint32
TEST.END_FLOW
TEST.END

-- Subprogram: sp_init_range

-- Test Case: sp_init_range.001_signal_range_sp_hwver_input__init_pool_memory()_TRUE
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:sp_init_range
TEST.NEW
TEST.NAME:sp_init_range.001_signal_range_sp_hwver_input__init_pool_memory()_TRUE
TEST.NOTES:
1st execution: sig_pool is sig_pool_1, signal_range is sp_hwver_input, init_pool_memory() returns TRUE: init_pool_memory() is called, pointer to 1st element of configs[] is returned.
2nd execution: sig_pool is sig_pool_1, signal_range is sp_hwver_input: pointer to 1st element of configs[] is returned.

/***/
Test is executed 2 times.
TEST.END_NOTES:
TEST.STUB:signal_pool.init_pool_memory
TEST.VALUE:signal_pool.init_pool_memory.return:true
TEST.VALUE:signal_pool.sp_init_range.sig_pool:(2)sig_pool_1
TEST.VALUE:signal_pool.sp_init_range.signal_range:sp_hwver_input
TEST.EXPECTED:signal_pool.init_pool_memory.sig_pool:sig_pool_1
TEST.FLOW
  signal_pool.c.sp_init_range
  signal_pool.c.init_pool_memory
  signal_pool.c.sp_init_range
  signal_pool.c.sp_init_range
  signal_pool.c.sp_init_range
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.sp_init_range.return
{{ <<signal_pool.sp_init_range.return>> == ( &<<signal_pool.<<GLOBAL>>.configs[0]>> ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: sp_init_range.002_signal_range_sp_complete_pool__init_pool_memory()_FALSE
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:sp_init_range
TEST.NEW
TEST.NAME:sp_init_range.002_signal_range_sp_complete_pool__init_pool_memory()_FALSE
TEST.NOTES:
sig_pool is sig_pool_2, signal_range is sp_complete_pool, init_pool_memory() returns FALSE: pointer to last element of configs[] is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.init_pool_memory
TEST.VALUE:signal_pool.init_pool_memory.return:false
TEST.VALUE:signal_pool.sp_init_range.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.sp_init_range.signal_range:sp_complete_pool
TEST.EXPECTED:signal_pool.init_pool_memory.sig_pool:sig_pool_2
TEST.FLOW
  signal_pool.c.sp_init_range
  signal_pool.c.init_pool_memory
  signal_pool.c.sp_init_range
TEST.END_FLOW
TEST.EXPECTED_USER_CODE:signal_pool.sp_init_range.return
{{ <<signal_pool.sp_init_range.return>> == ( &<<signal_pool.<<GLOBAL>>.configs[46]>> ) }}
TEST.END_EXPECTED_USER_CODE:
TEST.END

-- Test Case: sp_init_range.003_signal_range_invalid
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:sp_init_range
TEST.NEW
TEST.NAME:sp_init_range.003_signal_range_invalid
TEST.NOTES:
sig_pool is sig_pool_2, signal_range is invalid(sp_complete_pool + 1): NULL is returned.
TEST.END_NOTES:
TEST.STUB:signal_pool.init_pool_memory
TEST.VALUE:signal_pool.sp_init_range.sig_pool:sig_pool_2
TEST.VALUE:signal_pool.sp_init_range.signal_range:47
TEST.EXPECTED:signal_pool.sp_init_range.return:<<null>>
TEST.FLOW
  signal_pool.c.sp_init_range
  signal_pool.c.sp_init_range
TEST.END_FLOW
TEST.END

-- Test Case: sp_init_range.004_sig_pool_sig_nr_max_array_out_of_bounds
TEST.UNIT:signal_pool
TEST.SUBPROGRAM:sp_init_range
TEST.NEW
TEST.NAME:sp_init_range.004_sig_pool_sig_nr_max_array_out_of_bounds
TEST.NOTES:
sig_pool is sig_nr_max, signal_range is sp_complete_pool, init_pool_memory() returns FALSE: array out of bounds.

/***/
In case sig_pool is sig_nr_max, static array memory_is_initialized[] gets out of bounds at line 106.
TEST.END_NOTES:
TEST.STUB:signal_pool.init_pool_memory
TEST.VALUE:signal_pool.init_pool_memory.return:false
TEST.VALUE:signal_pool.sp_init_range.sig_pool:sig_nr_max
TEST.VALUE:signal_pool.sp_init_range.signal_range:sp_complete_pool
TEST.EXPECTED:signal_pool.init_pool_memory.sig_pool:sig_nr_max
TEST.EXPECTED:signal_pool.sp_init_range.return:<<null>>
TEST.FLOW
  signal_pool.c.sp_init_range
  signal_pool.c.init_pool_memory
  signal_pool.c.sp_init_range
TEST.END_FLOW
TEST.END
