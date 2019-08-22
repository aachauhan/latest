<?php

namespace Foo\BarModule\Setup;

use Magento\Framework\Setup\InstallDataInterface;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\ModuleDataSetupInterface;

class InstallData implements InstallDataInterface{
    /**
     * {@inheritdoc}
     */
    public function install(ModuleDataSetupInterface $setup, ModuleContextInterface $context)
    {
        // TODO: Implement install() method.
        $setup->startSetup();
        $setup->getConnection()->insert(
            $setup->getTable('barmodule_table'),
            [
                'name' => 'Item One'
            ]
        );

        $setup->getConnection()->insert(
            $setup->getTable('barmodule_table'),
            [
                'name' => 'Item Two'
            ]
        );

        $setup->endSetup();
    }
}
