# BoundaryConditions.EnforcedLoads.Velocity()

BoundaryConditions.EnforcedLoads.Velocity()

説明​

フェース、エッジ、または節点に強制速度を作成します。ユーザーは強制速度パラメータを入力し、指定した場所に強制速度を返します。

構文​

BoundaryConditions.EnforcedLoads.Velocity(...)

リボン：Boundary Conditions » Enforced Loads » Velocity

入力​

strName​

強制速度荷重名を指定する String です。

デフォルト値は "EnforcedVelocity1" です。

enforceVelocity​

強制速度パラメータを指定する ENFORCED_VELOCITY_LBC です。

これは必須の入力です。

crlTargets​

強制速度を適用する対象のリストを指定する Cursor リストです。対象はフェース、エッジ、または節点です。

これは必須の入力です。

crEdit​

既存の強制速度を指定する Cursor です。

このパラメータを使用すると、指定した強制速度が修正されます。

None の場合、新しい強制速度が作成されます。

デフォルト値は None です。

bADVCStatic​

ボルトの固定長のために2つの ADVC Static プロセスを作成するかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

作成された LBC を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

created_bcs = BoundaryConditions.EnforcedLoads.Velocity(enforceVelocity=ENFORCED_VELOCITY_LBC(iDwDof=1,
                                                                                              dVelocityTX=0.001), 
                                                        crlTargets=[Face(24)])

JPT.Debugger(created_bcs)
