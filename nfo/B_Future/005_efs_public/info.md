
<!-- Proyecto : # docs-tf -->
# Informacion de Terraform - Enfoque practico
<!-- Nivel 2 -  V0.0.1 - 2022 Ago-->

Vamos a intentar entender Fargate en base a una implementacion dada

Asumimos que esta en la subnet privada , pero tambien puede generar su propia subred

Las subredes son definidas en el servicio ECS

# Command: - stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout ..

```

[[VPC - 10.0.0.5 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I  [Subnet - 10.0.0.0/24 - 256 hosts ] - - - - - -- - - - - - - - - I
   I     I                                                             I
   I     I   [Fargate Cluster - 10.0.0.x ( N AZs )   ) ]               I
   I     I        I                                                    I
   I     I        I ( * Capacity provider [SPOT|FARGATE] )             I
   I     I        I                                                    V
   I   ++++++++  [ Fargate Task - 10.0.0.5  ]    [ <<<<<<   Fargate ECS Service >>>>>> ]    
   I     I                 I
   I     I                 I ( * Task Definition )
   I     I                 I ( * SG_Task         )
   I     I               [EFS]
```

# Entidades TF

aws_ecs_cluster --> Fargate Cluster

aws_ecs_cluster_capacity_provider



# Ref: https://hands-on.cloud/how-to-manage-amazon-efs-using-terraform/#h-efs-mount-target-vs-efs-access-point 