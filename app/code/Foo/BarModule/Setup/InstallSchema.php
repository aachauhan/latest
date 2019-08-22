<?php

namespace Foo\BarModule\Setup;

use Magento\Framework\Setup\InstallSchemaInterface;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\SchemaSetupInterface;
use Magento\Framework\DB\Ddl\Table;

class InstallSchema implements InstallSchemaInterface{
    /**
     * {@inheritdoc}
     */
    public function install(SchemaSetupInterface $setup, ModuleContextInterface $context)
    {
        $setup->startSetup();

        $table = $setup->getConnection()->newTable(
            $setup->getTable('barmodule_table')
        )->addColumn(
            'id',
            Table::TYPE_INTEGER,
            null,
            ['identity'=> true, 'nullable'=> false, 'primary'=> true],
            ['Item ID']
        )->addColumn(
            'name',
            Table::TYPE_TEXT,
            255,
            ['nullable' => false],
            ['Item Name']
        )->addIndex(
            $setup->getIdxName('barmodule_table', ['name']),
            ['name']
        )->setComment(
            'Sample Items'
        );

        $setup->getConnection()->createTable($table);

        $setup->endSetup();
    }
}
