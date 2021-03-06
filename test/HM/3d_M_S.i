[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 1
  ny = 10
  nz = 1
  ymax = 0
  ymin = -1
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Modules]
  [./TensorMechanics]
    [./Master]
      [./all]
      add_variables = true
      strain = SMALL
      generate_output = 'stress_yy vonmises_stress'
      [../]
    [../]
  [../]
  [./FluidProperties]
    [./water_uo]
      type = TigerWaterConst
    [../]
  [../]
[]

[Kernels]
  [./gravity_y]
    type = TigerMechanicsGravityM
    variable = disp_y
    component = 1
  [../]
[]

[BCs]
  [./no_x]
    type = DirichletBC
    variable = disp_x
    boundary = bottom
    value = 0.0
  [../]
  [./no_y]
    type = DirichletBC
    variable = disp_y
    boundary = bottom
    value = 0.0
  [../]
  [./no_z]
    type = DirichletBC
    variable = disp_z
    boundary = bottom
    value = 0.0
  [../]
[]

[Materials]
  [./Elasticity_tensor]
    type = ComputeElasticityTensor
    fill_method = symmetric_isotropic
    C_ijkl = '0 0.5e8'
  [../]
  [./stress]
    type = ComputeLinearElasticStress
  [../]
  [./rock_f]
    type = TigerFluidMaterial
    fp_uo = water_uo
  [../]
  [./rock_g]
    type = TigerGeometryMaterial
    gravity = '0 -9.8 0'
  [../]
  [./rock_p]
    type = TigerPorosityMaterial
    porosity = 0.2
    specific_density = 2500
  [../]
  [./rock_m]
    type = TigerMechanicsMaterialM
    disps = 'disp_x disp_y disp_z'
    incremental = false
  [../]
[]

[Executioner]
  type = Steady
  solve_type = PJFNK
  nl_abs_tol = 1e-10
  l_max_its = 20
[]

[Outputs]
  [./out]
    type = Exodus
    elemental_as_nodal = true
  [../]
[]
