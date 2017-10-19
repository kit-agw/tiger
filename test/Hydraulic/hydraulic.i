[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 1
[]

[UserObjects]
  [./water_uo]
    type =  TigerWaterProperties
  [../]
  [./rock_uo]
    type =  TigerPermeabilityRockConst
  [../]
[]

[Materials]
  [./water]
    type = TigerFluidMaterialTP
    pressure = 1.0e6
    temperature = 100.0
    fp_UO = water_uo
  [../]
  [./rock]
    type = TigerRockMaterial
    compressibility = 1.0e-8
    permeability_type = isotropic
    k0 = 1.0e-5
    porosity = 0.4
    kf_UO = rock_uo
  [../]
[]

[BCs]
  [./left]
    type =  DirichletBC
    variable = pressure
    boundary = left
    value = 0.0
  [../]
  [./right]
    type =  DirichletBC
    variable = pressure
    boundary = right
    value = 100
  [../]
[]

[AuxVariables]
  [./vx]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./vy]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./vz]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
  [./density]
    type = MaterialRealAux
    variable = den
    property = density
  [../]
  [./viscosity]
    type = MaterialRealAux
    variable = vis
    property = viscosity
  [../]
[]

[Variables]
  [./pressure]
  [../]
[]

[Kernels]
  [./diff]
    type = TigerKernelH
    variable = pressure
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true
[]
