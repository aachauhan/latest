<?php

namespace Foo\BarModule\Setup;

use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\ModuleDataSetupInterface;
use Magento\Framework\Setup\UpgradeDataInterface;

class UpgradeData implements UpgradeDataInterface
{
    /*
     * {@inheritdoc}
     */
    public function upgrade(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
    {
        $setup->startSetup();

        if (version_compare($context->getVersion(), '1.0.0') < 0) {
            $setup->getConnection()->update(
                $setup->getTable('barmodule_table'),
                [
                    'description' => 'change'
                ],
                $setup->getConnection()->quoteInto('id < ?', 3)
            );
        }

        $setup->endSetup();
    }
}
