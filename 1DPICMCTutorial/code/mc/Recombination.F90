!Module RecombinationModule
!     Use ParticleModule
!     Implicit none
!     contains
!       Subroutine  IonIonRecombinationRate(Nx,ParticlePositive,ParticleNegative,Weighting,Volume,dt)
!            Implicit none
!            Type(ParticleBundle),intent(inout) :: ParticlePositive,ParticleNegative
!            Real(8),intent(in) :: Weighting,Volume,dt
!            Real(8),parameter :: K0=2.7d-13 !G������ ����1d-13
!            Integer(4) :: i,Nx,N
!            Real(8) :: NumberPositive(Nx), NumberNegative(Nx),NumberRecombination(Nx),NumberRecombinationTemp(Nx)
!            
!            NumberPositive=0.d0
!            NumberNegative=0.d0
!            NumberRecombination=0.d0
!            NumberRecombinationTemp=0.d0
!            !Write (*,*)  ParticlePositive%Name,ParticlePositive%NPar,ParticleNegative%Name,ParticleNegative%NPar,'Before'
!            do i=1,ParticlePositive%NPar
!                       N=Ceiling(ParticlePositive%PhaseSpace(i)%X)
!                       NumberPositive(N)=NumberPositive(N)+1.d0   !���ÿ�������������� N
!            End do
!           
!            do i=1,ParticleNegative%NPar
!                       N=Ceiling(ParticleNegative%PhaseSpace(i)%X) !ͬ��
!                       NumberNegative(N)=NumberNegative(N)+1.d0 
!            End do
!           
!            NumberRecombination(1:Nx)=Weighting*K0/Volume*dt*NumberPositive(1:Nx)*NumberNegative(1:Nx) !Na*w*k*dt/V*Nb, Na*w*k*dt/V=n*v*sigame ע��(k=v*sigma)
!            
!            NumberRecombinationTemp(1:Nx)=NumberRecombination(1:Nx)
!            Call Recombination(ParticlePositive,Nx,NumberRecombinationTemp) !�������ϵ�������-del
!            
!            NumberRecombinationTemp(1:Nx)=NumberRecombination(1:Nx) !��Ϊ����ĵ��ú����Ѿ��ı���NumberRecombinationTempֵ����Ҫ���¸�ֵ
!            Call Recombination(ParticleNegative,Nx,NumberRecombinationTemp)  !�������ϵĸ�����-del
!            !Write (*,*)  ParticlePositive%Name,ParticlePositive%NPar,ParticleNegative%Name,ParticleNegative%NPar,'After'       
!           return
!       End Subroutine  IonIonRecombinationRate
!          
!       Subroutine  Recombination(InputParticle,Nx,NumberRecombination)
!               Implicit none
!               Integer(4),intent(in) ::  Nx
!               Type(ParticleBundle),intent(inout) :: InputParticle
!               Real(8),intent(inout) :: NumberRecombination(Nx)
!               Integer(4) :: i,N,IndexBegin
!               Real(8) :: Ratio
!               
!                   CALL RANDOM_NUMBER(R)
!                   IndexBegin=Ceiling(R*dble(InputParticle%Npar))  !���һ��������ʼ��
!                     
!                   do i=IndexBegin,1,-1   !�����Ƿֳ������֣������鶼������һ�£�---�Ľ���������һ�������������ж�����һ�������ﵽ �Ͳ����н�һ�����ж���
!                       N=Ceiling(InputParticle%PhaseSpace(i)%X) 
!                       If(NumberRecombination(N)>MinReal) Then
!                           If(NumberRecombination(N)>=1.d0)  Then
!                               NumberRecombination(N)=NumberRecombination(N)-1.d0
!                               Call DelParticle(i,InputParticle)
!                            Else
!                                 CALL RANDOM_NUMBER(R)
!                                 Ratio=NumberRecombination(N)
!                                 NumberRecombination(N)=NumberRecombination(N)-1.d0
!                                 If(R<Ratio)  Then
!                                    Call DelParticle(i,InputParticle)
!                                 End If 
!                             End if
!                        End if
!                 End do
!                 
!                i=IndexBegin+1
!                do while (i<=InputParticle%NPar)
!                       N=Ceiling(InputParticle%PhaseSpace(i)%X) 
!                       If(NumberRecombination(N)>MinReal) Then
!                           If(NumberRecombination(N)>=1.d0)  Then
!                               NumberRecombination(N)=NumberRecombination(N)-1.d0
!                               Call DelParticle(i,InputParticle)
!                            Else
!                                 CALL RANDOM_NUMBER(R)
!                                 Ratio=NumberRecombination(N)
!                                 NumberRecombination(N)=NumberRecombination(N)-1.d0
!                               If(R<Ratio)  Then
!                                 Call DelParticle(i,InputParticle)
!                                End If 
!                             End if
!                        End if
!                          i=i+1
!                 End do      
!               return
!          End Subroutine  Recombination
!
!  subroutine ElectronIonRecombinationRate(Nx,ParticlePositive,ParticleNegative,Weighting,Volume,dt) !�������û�н��д�����һ�������Ӧȷʵ���Ժ��ԣ�����̫����
!        implicit none
!        Type(ParticleBundle),intent(inout) :: ParticlePositive,ParticleNegative
!            Real(8),intent(in) :: Weighting,Volume,dt
!            Real(8),parameter :: K0=1d-13
!            Integer(4) :: i,Nx,N
!            Real(8) :: NumberPositive(Nx), NumberNegative(Nx),NumberRecombination(Nx),NumberRecombinationTemp(Nx)
!     
!
!        return
!   end subroutine ElectronIonRecombinationRate
!End Module RecombinationModule