{-# LANGUAGE CPP                #-}
{-# LANGUAGE FlexibleContexts   #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveDataTypeable #-}
module Tests.Orphanage where

#if !MIN_VERSION_base(4,8,0)
import           Control.Applicative
import           Data.Monoid as Monoid
#endif

#if MIN_VERSION_base(4,9,0)
import qualified Data.Semigroup as Semigroup
#endif

import           Data.Typeable

import           Data.Ord
import           Foreign.C.Types
import           System.Exit (ExitCode(..))
import           GHC.Fingerprint.Type

import           Test.QuickCheck.Gen
import           Test.QuickCheck.Arbitrary

import qualified Data.Vector.Primitive      as Vector.Primitive
import qualified Data.ByteString.Short      as BSS

--------------------------------------------------------------------------------
-- QuickCheck Orphans

-- A _LOT_ of orphans instances for QuickCheck. Some are already in
-- git HEAD and some are still waiting as pull request
--
-- [https://github.com/nick8325/quickcheck/pull/90]

-- Foreign C types

instance Arbitrary CChar where
  arbitrary = CChar <$> arbitrary
  shrink (CChar x) = CChar <$> shrink x

instance Arbitrary CSChar where
  arbitrary = CSChar <$> arbitrary
  shrink (CSChar x) = CSChar <$> shrink x

instance Arbitrary CUChar where
  arbitrary = CUChar <$> arbitrary
  shrink (CUChar x) = CUChar <$> shrink x

instance Arbitrary CShort where
  arbitrary = CShort <$> arbitrary
  shrink (CShort x) = CShort <$> shrink x

instance Arbitrary CUShort where
  arbitrary = CUShort <$> arbitrary
  shrink (CUShort x) = CUShort <$> shrink x

instance Arbitrary CInt where
  arbitrary = CInt <$> arbitrary
  shrink (CInt x) = CInt <$> shrink x

instance Arbitrary CUInt where
  arbitrary = CUInt <$> arbitrary
  shrink (CUInt x) = CUInt <$> shrink x

instance Arbitrary CLong where
  arbitrary = CLong <$> arbitrary
  shrink (CLong x) = CLong <$> shrink x

instance Arbitrary CULong where
  arbitrary = CULong <$> arbitrary
  shrink (CULong x) = CULong <$> shrink x

instance Arbitrary CPtrdiff where
  arbitrary = CPtrdiff <$> arbitrary
  shrink (CPtrdiff x) = CPtrdiff <$> shrink x

instance Arbitrary CSize where
  arbitrary = CSize <$> arbitrary
  shrink (CSize x) = CSize <$> shrink x

instance Arbitrary CWchar where
  arbitrary = CWchar <$> arbitrary
  shrink (CWchar x) = CWchar <$> shrink x

instance Arbitrary CSigAtomic where
  arbitrary = CSigAtomic <$> arbitrary
  shrink (CSigAtomic x) = CSigAtomic <$> shrink x

instance Arbitrary CLLong where
  arbitrary = CLLong <$> arbitrary
  shrink (CLLong x) = CLLong <$> shrink x

instance Arbitrary CULLong where
  arbitrary = CULLong <$> arbitrary
  shrink (CULLong x) = CULLong <$> shrink x

instance Arbitrary CIntPtr where
  arbitrary = CIntPtr <$> arbitrary
  shrink (CIntPtr x) = CIntPtr <$> shrink x

instance Arbitrary CUIntPtr where
  arbitrary = CUIntPtr <$> arbitrary
  shrink (CUIntPtr x) = CUIntPtr <$> shrink x

instance Arbitrary CIntMax where
  arbitrary = CIntMax <$> arbitrary
  shrink (CIntMax x) = CIntMax <$> shrink x

instance Arbitrary CUIntMax where
  arbitrary = CUIntMax <$> arbitrary
  shrink (CUIntMax x) = CUIntMax <$> shrink x

instance Arbitrary CClock where
  arbitrary = CClock <$> arbitrary
  shrink (CClock x) = CClock <$> shrink x

instance Arbitrary CTime where
  arbitrary = CTime <$> arbitrary
  shrink (CTime x) = CTime <$> shrink x

instance Arbitrary CUSeconds where
  arbitrary = CUSeconds <$> arbitrary
  shrink (CUSeconds x) = CUSeconds <$> shrink x

instance Arbitrary CSUSeconds where
  arbitrary = CSUSeconds <$> arbitrary
  shrink (CSUSeconds x) = CSUSeconds <$> shrink x

instance Arbitrary CFloat where
  arbitrary = CFloat <$> arbitrary
  shrink (CFloat x) = CFloat <$> shrink x

instance Arbitrary CDouble where
  arbitrary = CDouble <$> arbitrary
  shrink (CDouble x) = CDouble <$> shrink x

-- Miscellaneous types from base

#if MIN_VERSION_base(4,9,0)
instance Arbitrary a => Arbitrary (Semigroup.Min a) where
  arbitrary = fmap Semigroup.Min arbitrary
  shrink = map Semigroup.Min . shrink . Semigroup.getMin

instance Arbitrary a => Arbitrary (Semigroup.Max a) where
  arbitrary = fmap Semigroup.Max arbitrary
  shrink = map Semigroup.Max . shrink . Semigroup.getMax

instance Arbitrary a => Arbitrary (Semigroup.First a) where
  arbitrary = fmap Semigroup.First arbitrary
  shrink = map Semigroup.First . shrink . Semigroup.getFirst

instance Arbitrary a => Arbitrary (Semigroup.Last a) where
  arbitrary = fmap Semigroup.Last arbitrary
  shrink = map Semigroup.Last . shrink . Semigroup.getLast

instance Arbitrary a => Arbitrary (Semigroup.Option a) where
  arbitrary = fmap Semigroup.Option arbitrary
  shrink = map Semigroup.Option . shrink . Semigroup.getOption

instance Arbitrary a => Arbitrary (Semigroup.WrappedMonoid a) where
  arbitrary = fmap Semigroup.WrapMonoid arbitrary
  shrink = map Semigroup.WrapMonoid . shrink . Semigroup.unwrapMonoid
#endif

instance Arbitrary a => Arbitrary (Down a) where
  arbitrary = fmap Down arbitrary
  shrink = map Down . shrink . (\(Down a) -> a)

instance Arbitrary ExitCode where
  arbitrary = frequency [(1, return ExitSuccess), (3, fmap ExitFailure arbitrary)]

  shrink (ExitFailure x) = ExitSuccess : [ ExitFailure x' | x' <- shrink x ]
  shrink _        = []

#if !MIN_VERSION_base(4,8,0)
deriving instance Typeable Const
deriving instance Typeable ZipList
deriving instance Typeable Down
deriving instance Typeable Monoid.Sum
deriving instance Typeable Monoid.All
deriving instance Typeable Monoid.Any
deriving instance Typeable Monoid.Product
deriving instance Typeable Monoid.Dual
deriving instance Typeable Fingerprint

deriving instance Show a => Show (Const a b)
deriving instance Eq a   => Eq   (Const a b)
#endif

instance Arbitrary BSS.ShortByteString where
  arbitrary = BSS.pack <$> arbitrary

instance (Vector.Primitive.Prim a, Arbitrary a
         ) => Arbitrary (Vector.Primitive.Vector a) where
    arbitrary = Vector.Primitive.fromList <$> arbitrary

#if MIN_VERSION_base(4,7,0)
instance Arbitrary (Proxy a) where
  arbitrary = return Proxy
#endif

instance Arbitrary Fingerprint where
  arbitrary = Fingerprint <$> arbitrary <*> arbitrary
