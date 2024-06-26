// RUN: tcp-opt %s -split-input-file -verify-diagnostics | FileCheck %s

// CHECK-LABEL: func.func @test_tanh_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[TANH:.*]] = tcp.tanh %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[TANH]] : tensor<?x?xf32>
func.func @test_tanh_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.tanh %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_tanh_diff_rank(%arg0 : tensor<?xf32>) -> tensor<?x?xf32> {
  // expected-error@+1{{'tcp.tanh' op all non-scalar operands/results must have the same shape and base type}}
  %0 = tcp.tanh %arg0 : tensor<?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_tanh_diff_shape(%arg0 : tensor<5x?xf32>) -> tensor<6x?xf32> {
  // expected-error@+1{{'tcp.tanh' op all non-scalar operands/results must have the same shape and base type}}
  %0 = tcp.tanh %arg0 : tensor<5x?xf32> -> tensor<6x?xf32>
  return %0 : tensor<6x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_clamp_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[CLAMP:.*]] = tcp.clamp %[[ARG]] {min_float = 0.000000e+00 : f32} : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[CLAMP]] : tensor<?x?xf32>
func.func @test_clamp_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.clamp %arg0 { min_float = 0.0 : f32 } : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_clamp_i32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xi32>) -> tensor<?x?xi32>
// CHECK:         %[[CLAMP:.*]] = tcp.clamp %[[ARG]] {max_int = 6 : i64} : tensor<?x?xi32> -> tensor<?x?xi32>
// CHECK:         return %[[CLAMP]] : tensor<?x?xi32>
func.func @test_clamp_i32(%arg0 : tensor<?x?xi32>) -> tensor<?x?xi32> {
  %0 = tcp.clamp %arg0 { max_int = 6 : i64 } : tensor<?x?xi32> -> tensor<?x?xi32>
  return %0 : tensor<?x?xi32>
}

// -----

func.func @test_clamp_no_min_max(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  // expected-error@+1{{'tcp.clamp' op failed to verify that at least one of min / max attributes must be set}}
  %0 = tcp.clamp %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_clamp_min_invalid(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  // expected-error@+1{{'tcp.clamp' op failed to verify that int min / max attributes must not be set when input is a float tensor}}
  %0 = tcp.clamp %arg0 { max_int = 6 : i64 } : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_sigmoid_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[TANH:.*]] = tcp.sigmoid %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[TANH]] : tensor<?x?xf32>
func.func @test_sigmoid_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.sigmoid %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_sqrt_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[SQRT:.*]] = tcp.sqrt %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[SQRT]] : tensor<?x?xf32>
func.func @test_sqrt_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.sqrt %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_ceil_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[CEIL:.*]] = tcp.ceil %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[CEIL]] : tensor<?x?xf32>
func.func @test_ceil_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.ceil %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_floor_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[FLOOR:.*]] = tcp.floor %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[FLOOR]] : tensor<?x?xf32>
func.func @test_floor_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.floor %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_round_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[ROUND:.*]] = tcp.round %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[ROUND]] : tensor<?x?xf32>
func.func @test_round_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.round %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_round_even_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[ROUND:.*]] = tcp.round_even %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[ROUND]] : tensor<?x?xf32>
func.func @test_round_even_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.round_even %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_sin_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[SIN:.*]] = tcp.sin %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[SIN]] : tensor<?x?xf32>
func.func @test_sin_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.sin %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_cos_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[COS:.*]] = tcp.cos %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[COS]] : tensor<?x?xf32>
func.func @test_cos_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.cos %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_abs_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[ABS:.*]] = tcp.abs %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[ABS]] : tensor<?x?xf32>
func.func @test_abs_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.abs %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_abs_i32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xi32>) -> tensor<?x?xi32>
// CHECK:         %[[ABS:.*]] = tcp.abs %[[ARG]] : tensor<?x?xi32> -> tensor<?x?xi32>
// CHECK:         return %[[ABS]] : tensor<?x?xi32>
func.func @test_abs_i32(%arg0 : tensor<?x?xi32>) -> tensor<?x?xi32> {
  %0 = tcp.abs %arg0 : tensor<?x?xi32> -> tensor<?x?xi32>
  return %0 : tensor<?x?xi32>
}

// -----

// CHECK-LABEL: func.func @test_log_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[LOG:.*]] = tcp.log %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[LOG]] : tensor<?x?xf32>
func.func @test_log_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.log %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_neg_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[NEG:.*]] = tcp.neg %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[NEG]] : tensor<?x?xf32>
func.func @test_neg_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.neg %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

// CHECK-LABEL: func.func @test_atan_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:         %[[ATAN:.*]] = tcp.atan %[[ARG]] : tensor<?x?xf32> -> tensor<?x?xf32>
// CHECK:         return %[[ATAN]] : tensor<?x?xf32>
func.func @test_atan_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %0 = tcp.atan %arg0 : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_cast_i32_f32(%arg0 : tensor<?x?xi32>) -> tensor<?x?xf32> {
  // expected-error@+1{{tcp.cast' op in_int_signedness attr must be set when input is INT}}
  %0 = tcp.cast %arg0 : tensor<?x?xi32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_cast_i32_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xi16> {
  // expected-error@+1{{tcp.cast' op out_int_signedness attr must be set when output is INT}}
  %0 = tcp.cast %arg0 : tensor<?x?xf32> -> tensor<?x?xi16>
  return %0 : tensor<?x?xi16>
}

// -----

func.func @test_cast_f32_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  // expected-error@+1{{tcp.cast' op in_int_signedness attr should not set when input is FP}}
  %0 = tcp.cast %arg0 {in_int_signedness = #tcp<signedness Signed>} : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_cast_f32_f32(%arg0 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  // expected-error@+1{{tcp.cast' op out_int_signedness attr should not set when output is FP}}
  %0 = tcp.cast %arg0 {out_int_signedness = #tcp<signedness Signed>} : tensor<?x?xf32> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_cast_i1_f32(%arg0 : tensor<?x?xi1>) -> tensor<?x?xf32> {
  // expected-error@+1{{tcp.cast' op in_int_signedness attr must be set to Signedness::Signless when input is i1}}
  %0 = tcp.cast %arg0 {in_int_signedness = #tcp<signedness Signed>} : tensor<?x?xi1> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}

// -----

func.func @test_cast_f32_i1(%arg0 : tensor<?x?xf32>) -> tensor<?x?xi1> {
  // expected-error@+1{{tcp.cast' op out_int_signedness attr must be set to Signedness::Signless when output is i1}}
  %0 = tcp.cast %arg0 {out_int_signedness = #tcp<signedness Signed>} : tensor<?x?xf32> -> tensor<?x?xi1>
  return %0 : tensor<?x?xi1>
}

// -----

// CHECK-LABEL: func.func @test_cast_i32_i8(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xi32>) -> tensor<?x?xi8>
// CHECK:         %[[OUT:.*]] = tcp.cast %[[ARG]] {in_int_signedness = #tcp<signedness Signed>, out_int_signedness = #tcp<signedness Unsigned>} : tensor<?x?xi32> -> tensor<?x?xi8>
// CHECK:         return %[[OUT]] : tensor<?x?xi8>
func.func @test_cast_i32_i8(%arg0 : tensor<?x?xi32>) -> tensor<?x?xi8> {
  %0 = tcp.cast %arg0 {in_int_signedness = #tcp<signedness Signed>, out_int_signedness = #tcp<signedness Unsigned>} : tensor<?x?xi32> -> tensor<?x?xi8>
  return %0 : tensor<?x?xi8>
}

// -----

// CHECK-LABEL: func.func @test_cast_i32_f16(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xi32>) -> tensor<?x?xf16>
// CHECK:         %[[OUT:.*]] = tcp.cast %[[ARG]] {in_int_signedness = #tcp<signedness Unsigned>} : tensor<?x?xi32> -> tensor<?x?xf16>
// CHECK:         return %[[OUT]] : tensor<?x?xf16>
func.func @test_cast_i32_f16(%arg0 : tensor<?x?xi32>) -> tensor<?x?xf16> {
  %0 = tcp.cast %arg0 {in_int_signedness = #tcp<signedness Unsigned>} : tensor<?x?xi32> -> tensor<?x?xf16>
  return %0 : tensor<?x?xf16>
}

// -----

// CHECK-LABEL: func.func @test_cast_f16_i32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf16>) -> tensor<?x?xi32>
// CHECK:         %[[OUT:.*]] = tcp.cast %[[ARG]] {out_int_signedness = #tcp<signedness Signless>} : tensor<?x?xf16> -> tensor<?x?xi32>
// CHECK:         return %[[OUT]] : tensor<?x?xi32>
func.func @test_cast_f16_i32(%arg0 : tensor<?x?xf16>) -> tensor<?x?xi32> {
  %0 = tcp.cast %arg0 {out_int_signedness = #tcp<signedness Signless>} : tensor<?x?xf16> -> tensor<?x?xi32>
  return %0 : tensor<?x?xi32>
}

// -----

// CHECK-LABEL: func.func @test_cast_f16_f32(
// CHECK-SAME:               %[[ARG:.*]]: tensor<?x?xf16>) -> tensor<?x?xf32>
// CHECK:         %[[OUT:.*]] = tcp.cast %[[ARG]] : tensor<?x?xf16> -> tensor<?x?xf32>
// CHECK:         return %[[OUT]] : tensor<?x?xf32>
func.func @test_cast_f16_f32(%arg0 : tensor<?x?xf16>) -> tensor<?x?xf32> {
  %0 = tcp.cast %arg0 : tensor<?x?xf16> -> tensor<?x?xf32>
  return %0 : tensor<?x?xf32>
}
